unit uUnit1;

interface

uses 
  SmartCL.System;

type
  TBase = class(TObject)
  protected
    Field: string = 'hello';
  public
    { Not exposed / visible by RTTI }
    property Hidden: string read Field write Field;
  published
    { visible by RTTI }
    property Stuff: string read Field write Field;
    { Not Published by RTTI? }
    procedure Foo;
  end;

type
  TExample = class(TBase)
  private
   FValue : Integer;
  public
    //[dwsPublished]
    procedure DecValue;
  published
    constructor Create(val : Integer);
    SeeMe: string = 'Fields working too';
    function GiveMe: string;
    property Value : Integer read FValue write FValue;
    property Another: string read Field;
  end;

implementation

procedure TBase.Foo;
begin
  Field := 'Hello World';
end;

function TExample.GiveMe: string;
begin
  result := Field
end;

constructor TExample.Create(val: Integer);
begin
  inherited Create;
  FValue := val;
end;

procedure TExample.DecValue;
begin
  WriteLn(FValue);
end;

end.
