unit Form104;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm104 = class(TW3Form)
  private
    {$I 'Form104:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm104 }

procedure TForm104.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm104.InitializeObject;
begin
  inherited;
  {$I 'Form104:impl'}
end;
 
procedure TForm104.Resize;
begin
  inherited;
end;

procedure TForm104.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm104);
end.
