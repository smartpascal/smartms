unit Form352;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm352 = class(TW3Form)
  private
    {$I 'Form352:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm352 }

procedure TForm352.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm352.InitializeObject;
begin
  inherited;
  {$I 'Form352:impl'}
end;
 
procedure TForm352.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm352);
end.
