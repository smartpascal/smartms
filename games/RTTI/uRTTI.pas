unit uRTTI;

interface

uses 
  W3C.Console;
  //SmartCL.System;

type
  MyAttrib = class (TCustomAttribute);

type
  [MyAttrib]
  TTest1 = class
  end;

  [TCustomAttribute]
  [MyAttrib]
  TTest2 = class
  end;

procedure Example1;

implementation

procedure PrintAttributes(obj: TClass);
begin
//new TW3CustomControl();
  //W3Memo1.Text := W3Memo1.Text + obj.ClassName + #13#10;
  Console.log(  obj.ClassName + #13#10 );

  var rtti := RTTIRawAttributes;
  var typeID := TypeOf(obj.ClassType);

  for var j:=Low(rtti) to High(rtti) do
    if variant(rtti[j]).T.ID = variant(typeID).ID then
      //W3Memo1.Text := W3Memo1.Text + '  [' + rtti[j].A.ClassName + ']'#13#10;
      console.log('  [' + rtti[j].A.ClassName + ']'#13#10 );
end;

procedure Example1;
begin
  //W3Memo1.Text := '';
  PrintAttributes(TTest1);
  PrintAttributes(TTest2);
end;


end.
