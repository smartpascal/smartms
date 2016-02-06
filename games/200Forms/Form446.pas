unit Form446;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm446 = class(TW3Form)
  private
    {$I 'Form446:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm446 }

procedure TForm446.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm446.InitializeObject;
begin
  inherited;
  {$I 'Form446:impl'}
end;
 
procedure TForm446.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm446);
end.
