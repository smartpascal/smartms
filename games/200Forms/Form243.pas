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
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
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

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm243);
end.
