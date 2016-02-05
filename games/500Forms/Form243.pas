unit Form243;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm243 = class(TW3Form)
  private
    {$I 'Form243:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm243 }

procedure TForm243.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm243.InitializeObject;
begin
  inherited;
  {$I 'Form243:impl'}
end;
 
procedure TForm243.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm243);
end.
