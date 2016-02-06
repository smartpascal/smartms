unit Form394;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm394 = class(TW3Form)
  private
    {$I 'Form394:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm394 }

procedure TForm394.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm394.InitializeObject;
begin
  inherited;
  {$I 'Form394:impl'}
end;
 
procedure TForm394.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm394);
end.
