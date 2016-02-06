unit Form80;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm80 = class(TW3Form)
  private
    {$I 'Form80:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm80 }

procedure TForm80.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm80.InitializeObject;
begin
  inherited;
  {$I 'Form80:impl'}
end;
 
procedure TForm80.Resize;
begin
  inherited;
end;

procedure TForm80.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm80);
end.
