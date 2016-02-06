unit Form244;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm244 = class(TW3Form)
  private
    {$I 'Form244:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm244 }

procedure TForm244.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm244.InitializeObject;
begin
  inherited;
  {$I 'Form244:impl'}
end;
 
procedure TForm244.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm244);
end.
