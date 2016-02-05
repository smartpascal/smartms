unit Form181;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm181 = class(TW3Form)
  private
    {$I 'Form181:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm181 }

procedure TForm181.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm181.InitializeObject;
begin
  inherited;
  {$I 'Form181:impl'}
end;
 
procedure TForm181.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm181);
end.
