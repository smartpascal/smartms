{ **************************************************************************** }
{                                                                              }
{ Unit testing Framework for SmartPascal and DWScript                          }
{                                                                              }
{ Copyright (c) Eric Grange, Creative IT. All rights reserved.                 }
{ Licensed to Optimale Systemer AS.                                            }
{                                                                              }
{ **************************************************************************** }

unit TestFramework;

interface

type
   TestStatus = enum (NotRun, Running, Failed, Passed);

   TAbstractTestCase = class;

   ITestListener = interface
      procedure BeginTest(test : TAbstractTestCase);
      procedure EndTest(test : TAbstractTestCase);
      procedure Failed(test : TAbstractTestCase; msg : String);
   end;

   TAbstractTestCase = class
      private
         FListener : ITestListener;

      protected
         property Listener : ITestListener read FListener;

      public
         constructor Create; virtual; empty;

         property Name : String;

         property Disabled : Boolean;
         property Enabled : Boolean read (not Disabled) write (Disabled:=not Value);

         property Status : TestStatus;
         property Failed : Boolean read (Status=TestStatus.Failed);
         property Passed : Boolean read (Status=TestStatus.Passed);

         property BeginTime : Float;
         property EndTime : Float;
         property Elapsed : Float read (EndTime-BeginTime);

         property NbChecks : Integer;

         procedure Run(listener : ITestListener);
         procedure DoRun; virtual; empty;

         procedure Setup; virtual; empty;
         procedure Teardown; virtual; empty;

         property  ActiveTest : TAbstractTestCase;
         procedure Pass;
         procedure Fail(msg : String); overload;
         procedure Fail(fmt : String; const args : array of const; msg : String); overload;

         procedure Check(v : Boolean; msg : String = ''); overload;

         procedure Equal(expected, actual : Integer; msg : String = ''); overload;
         procedure Equal(expected, actual : Float; msg : String = ''); overload;
         procedure Equal(expected, actual : String; msg : String = ''); overload;
         procedure Equal(expected, actual : Boolean; msg : String = ''); overload;
         procedure Equal(expected, actual : TObject; msg : String = ''); overload;

         procedure CheckNoException(proc : procedure; msg : String);
   end;

   TAbstractTestCases = array of TAbstractTestCase;
   TAbstractTestCaseClass = class of TAbstractTestCase;

   TTestSuite = class (TAbstractTestCase)
      private
         FTests : TAbstractTestCases;
      protected

      public
         property Tests : TAbstractTestCases read FTests;
         procedure Add(test : TAbstractTestCase);
         procedure DoRun; override;
   end;

   TTestCase = class (TTestSuite)
      public
         constructor Create; override;
   end;

   TTestFrameWork = static class
      private
         class var vSuites : TTestSuite;

      public
         class procedure Register(const suiteName : String; aTest : TAbstractTestCaseClass);

         class property Suites[idx : Integer] : TTestSuite read (vSuites.Tests[idx] as TTestSuite);
         class property Count : Integer read (vSuites.Tests.Count);

         class procedure Run(listener : ITestListener);
   end;

   TMethodTestCase = class (TAbstractTestCase)
      private
         FCase : TTestCase;
         FMethod : RTTIMethodAttribute;

      public
         procedure DoRun; override;
   end;

   ETestFailure = class(Exception);

implementation

uses W3C.Console;
(* ═══════════════════════════════════════════════════════
   TAbstractTestCase
  ═══════════════════════════════════════════════════════*)

procedure TAbstractTestCase.Run(listener: ITestListener);
begin
   FListener:=listener;
   listener.BeginTest(Self);
   NbChecks:=0;
   Status:=TestStatus.Running;
   ActiveTest:=Self;
   try
      CheckNoException(Setup, 'Setup failed');
      DoRun;
      if (NbChecks=0) and not Failed then begin
         Status:=TestStatus.Failed;
         listener.Failed(Self, 'No checks');
      end;
      CheckNoException(Teardown, 'Teardown failed');
   except
      on E : ETestFailure do ;
      on E : Exception do begin
         Status:=TestStatus.Failed;
         listener.Failed(Self, E.ClassName+': '+E.Message);
      end;
   end;
   if Status=TestStatus.Running then
      Status:=TestStatus.Passed;
   listener.EndTest(Self);
   FListener:=nil;
end;

procedure TAbstractTestCase.Pass;
begin
   NbChecks:=NbChecks+1;
end;

procedure TAbstractTestCase.Fail(msg: String);
begin
   NbChecks:=NbChecks+1;
   ActiveTest.Status:=TestStatus.Failed;
   FListener.Failed(ActiveTest, msg);
   raise ETestFailure.Create(msg);
end;

procedure TAbstractTestCase.Fail(fmt: String; const args: array of const; msg: String);
begin
   if msg='' then
      Fail(Format(fmt, args))
   else Fail(Format(fmt, args)+', '+msg);
end;

procedure TAbstractTestCase.Check(v: Boolean; msg: String = '');
begin
   if v then Pass else Fail(msg);
end;

procedure TAbstractTestCase.Equal(expected, actual: Integer; msg: String = '');
begin
   if expected=actual then
      Pass
   else Fail('%d expected but got %d', [expected, actual], msg);
end;

procedure TAbstractTestCase.Equal(expected, actual: Float; msg: String = '');
begin
   if expected=actual then
      Pass
   else Fail('%f expected but got %f', [expected, actual], msg);
end;

procedure TAbstractTestCase.Equal(expected, actual: String; msg: String = '');
begin
   if expected=actual then
      Pass
   else Fail('<%s> expected but got <%s>', [expected, actual], msg);
end;

procedure TAbstractTestCase.Equal(expected, actual: Boolean; msg: String = '');
begin
   if expected=actual then
      Pass
   else Fail( BoolToStr(expected)+' expected but got '+BoolToStr(actual)
             +if msg<>'' then (', '+msg));
end;

procedure TAbstractTestCase.Equal(expected, actual: TObject; msg: String = '');
begin
   if expected=actual then
      Pass
   else Fail('Object mismatch', [], msg);
end;

procedure TAbstractTestCase.CheckNoException(proc: procedure; msg: String);
begin
   try
      proc();
      Pass;
   except
      on E : Exception do
         Fail('%s: %s', [E.ClassName, E.Message], msg);
   end;
end;

(* ═══════════════════════════════════════════════════════
   TTestSuite
  ═══════════════════════════════════════════════════════*)
procedure TTestSuite.Add(test: TAbstractTestCase);
begin
   FTests.Add(test);
end;

procedure TTestSuite.DoRun;
var
   test : TAbstractTestCase;
begin
   try
      for test in FTests do begin
         if test.Disabled then continue;
         ActiveTest:=test;
         test.Run(Listener);
         if test.Failed then
            Status:=TestStatus.Failed;
      end;
   finally
      ActiveTest:=Self;
   end;
end;

(* ═══════════════════════════════════════════════════════
   TTestFrameWork
  ═══════════════════════════════════════════════════════*)

class procedure TTestFrameWork.Register(const suiteName: String; aTest: TAbstractTestCaseClass);
begin
   if not Assigned(vSuites) then begin
      vSuites:=TTestSuite.Create;
      vSuites.Name:='TestFramework';
   end;
   var suite : TTestSuite;
   for var i := 0 to vSuites.Tests.Count-1 do begin
      if vSuites.Tests[i].Name = 'suiteName' then begin
         suite := vSuites.Tests[i] as TTestSuite;
         break;
      end;
   end;
   if suite = nil then begin
      suite := TTestSuite.Create;
      suite.Name := suiteName;
      vSuites.Add(suite);
   end;
   var test := aTest.Create;
   test.Name := aTest.ClassName;
   suite.Add(test);
end;

class procedure TTestFrameWork.Run(listener: ITestListener);
begin
   if Assigned(vSuites) then
      vSuites.Run(listener);
end;

(* ═══════════════════════════════════════════════════════
   TTestFrameWork
  ═══════════════════════════════════════════════════════*)

constructor TTestCase.Create;
begin
   var rtti := RTTIRawAttributes;
   var typeID := TypeOf(ClassType);
   for var i:=Low(rtti) to High(rtti) do begin
      var attrib := rtti[i];
      if (variant(attrib).T.ID = variant(typeID).ID) and (attrib.A.ClassType = RTTIMethodAttribute) then begin
         var test := TMethodTestCase.Create;
         test.FMethod := RTTIMethodAttribute(attrib.A);
         test.FCase := Self;
         test.Name := test.FMethod.Name;
         //console.log(test.Name);
         Add(test);
      end;
   end;
end;

(* ═══════════════════════════════════════════════════════
   TMethodTestCase
  ═══════════════════════════════════════════════════════*)
procedure TMethodTestCase.DoRun;
begin
   FMethod.Call(FCase, []);
end;

end.

