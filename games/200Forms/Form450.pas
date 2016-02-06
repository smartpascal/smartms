unit Form450;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm450 = class(TW3Form)
  private
    {$I 'Form450:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm450 }

procedure TForm450.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm450.InitializeObject;
begin
  inherited;
  {$I 'Form450:impl'}
end;
 
procedure TForm450.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm450);
end.
