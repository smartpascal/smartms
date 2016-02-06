unit Form315;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm315 = class(TW3Form)
  private
    {$I 'Form315:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm315 }

procedure TForm315.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm315.InitializeObject;
begin
  inherited;
  {$I 'Form315:impl'}
end;
 
procedure TForm315.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm315);
end.
