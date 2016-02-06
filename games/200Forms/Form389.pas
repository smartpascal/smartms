unit Form389;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm389 = class(TW3Form)
  private
    {$I 'Form389:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm389 }

procedure TForm389.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm389.InitializeObject;
begin
  inherited;
  {$I 'Form389:impl'}
end;
 
procedure TForm389.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm389);
end.
