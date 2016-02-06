unit Form350;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm350 = class(TW3Form)
  private
    {$I 'Form350:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm350 }

procedure TForm350.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm350.InitializeObject;
begin
  inherited;
  {$I 'Form350:impl'}
end;
 
procedure TForm350.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm350);
end.
