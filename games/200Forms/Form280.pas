unit Form280;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm280 = class(TW3Form)
  private
    {$I 'Form280:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm280 }

procedure TForm280.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm280.InitializeObject;
begin
  inherited;
  {$I 'Form280:impl'}
end;
 
procedure TForm280.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm280);
end.
