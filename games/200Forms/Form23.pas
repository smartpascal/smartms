unit Form23;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm23 = class(TW3Form)
  private
    {$I 'Form23:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm23 }

procedure TForm23.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm23.InitializeObject;
begin
  inherited;
  {$I 'Form23:impl'}
end;
 
procedure TForm23.Resize;
begin
  inherited;
end;

procedure TForm23.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm23);
end.
