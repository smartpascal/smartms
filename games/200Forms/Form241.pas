unit Form241;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm241 = class(TW3Form)
  private
    {$I 'Form241:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm241 }

procedure TForm241.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm241.InitializeObject;
begin
  inherited;
  {$I 'Form241:impl'}
end;
 
procedure TForm241.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm241);
end.
