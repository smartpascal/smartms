unit Form402;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm402 = class(TW3Form)
  private
    {$I 'Form402:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm402 }

procedure TForm402.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm402.InitializeObject;
begin
  inherited;
  {$I 'Form402:impl'}
end;
 
procedure TForm402.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm402);
end.
