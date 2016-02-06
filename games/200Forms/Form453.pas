unit Form453;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm453 = class(TW3Form)
  private
    {$I 'Form453:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm453 }

procedure TForm453.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm453.InitializeObject;
begin
  inherited;
  {$I 'Form453:impl'}
end;
 
procedure TForm453.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm453);
end.
