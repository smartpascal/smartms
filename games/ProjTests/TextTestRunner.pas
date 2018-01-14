{ **************************************************************************** }
{                                                                              }
{ Unit testing Framework for SmartPascal and DWScript                          }
{                                                                              }
{ Copyright (c) Eric Grange, Creative IT. All rights reserved.                 }
{ Licensed to Optimale Systemer AS.                                            }
{                                                                              }
{ **************************************************************************** }

unit TextTestRunner;

interface

uses TestFramework, System.Diagnostics;

type
   TTextOutProc = procedure (s : String);

   TTextTestRunner = class (ITestListener)
      private
         FIndent : Integer;
         FIndentString : String;

      public
         procedure BeginTest(test : TAbstractTestCase); 
         procedure EndTest(test : TAbstractTestCase); 
         procedure Failed(test : TAbstractTestCase; msg : String); 

         property OnTextOut : TTextOutProc;
         procedure TextOut(s : String; BGcolor: string = '#00ff00'; color: string = 'blue');

         procedure Run;
   end;

implementation

var Console external 'console': Variant;

(* ═══════════════════════════════════════════════════════
   TTextTestRunner
  ═══════════════════════════════════════════════════════*)
procedure TTextTestRunner.TextOut(s: String; BGcolor: string; color: string);
begin
   if Assigned(OnTextOut) then
      OnTextOut(FIndentString+s)
   else console.log('%c'+FIndentString+s, 'background: #222; color: '+BGcolor, color);
end;

procedure TTextTestRunner.BeginTest(test: TAbstractTestCase);
begin
   if test is TTestSuite then begin
      TextOut('BEGIN '+test.Name+'  %c', 'cyan', 'background: #222;');
      Inc(FIndent, 2);
      FIndentString:=StringOfChar(' ', FIndent);
   end;
   test.BeginTime:=PerformanceTimer.Now;
end;

procedure TTextTestRunner.EndTest(test: TAbstractTestCase);
begin
   test.EndTime:=PerformanceTimer.Now;
   if test is TTestSuite then begin
      Dec(FIndent, 2);
      FIndentString:=StringOfChar(' ', FIndent);
      TextOut( 'END '
              +test.Name
              +(if test.Failed then ' failed' else ' passed')
              +"%c"+Format(' (%.1f ms)', [test.Elapsed]), 'cyan');
   end else if test.Passed then begin
      console.info('%c '+FIndentString+test.Name+' passed '+"%c"+Format(' (%.1f ms)', [test.Elapsed]), 'background: green;color: white;', '#00ff00');
   end;
end;

procedure TTextTestRunner.Failed(test: TAbstractTestCase; msg: String);
begin
   console.error('%c'+ FIndentString+test.Name+' failed'
                 +if msg<>'' then ': '+"%c "+msg, 'background: red; color:white', 'blue');

end;

procedure TTextTestRunner.Run;
begin
   TTestFrameWork.Run(Self as ITestListener);
end;

end.