unit Form50;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm50 = class(TW3Form)
  private
    {$I 'Form50:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm50 }

procedure TForm50.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm50.InitializeObject;
begin
  inherited;
  {$I 'Form50:impl'}
end;
 
procedure TForm50.Resize;
begin
  inherited;
end;

procedure TForm50.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm50);
end.
