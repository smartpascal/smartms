unit Form292;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm292 = class(TW3Form)
  private
    {$I 'Form292:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm292 }

procedure TForm292.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm292.InitializeObject;
begin
  inherited;
  {$I 'Form292:impl'}
end;
 
procedure TForm292.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm292);
end.
