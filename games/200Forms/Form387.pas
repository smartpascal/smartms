unit Form387;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm387 = class(TW3Form)
  private
    {$I 'Form387:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm387 }

procedure TForm387.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm387.InitializeObject;
begin
  inherited;
  {$I 'Form387:impl'}
end;
 
procedure TForm387.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm387);
end.
