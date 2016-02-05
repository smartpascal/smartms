unit Form102;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm102 = class(TW3Form)
  private
    {$I 'Form102:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm102 }

procedure TForm102.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm102.InitializeObject;
begin
  inherited;
  {$I 'Form102:impl'}
end;
 
procedure TForm102.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm102);
end.
