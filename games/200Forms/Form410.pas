unit Form410;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm410 = class(TW3Form)
  private
    {$I 'Form410:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm410 }

procedure TForm410.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm410.InitializeObject;
begin
  inherited;
  {$I 'Form410:impl'}
end;
 
procedure TForm410.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm410);
end.
