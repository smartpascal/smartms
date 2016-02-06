unit Form297;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm297 = class(TW3Form)
  private
    {$I 'Form297:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm297 }

procedure TForm297.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm297.InitializeObject;
begin
  inherited;
  {$I 'Form297:impl'}
end;
 
procedure TForm297.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm297);
end.
