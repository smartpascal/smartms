unit Form200;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button;

type
  TForm200 = class(TW3Form)
procedure W3Button1Click(Sender: TObject);
  private
    {$I 'Form200:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm200 }

procedure TForm200.W3Button1Click(Sender: TObject);
begin
 Application.gotoForm('Form1',feToLeft);
end;

procedure TForm200.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm200.InitializeObject;
begin
  inherited;
  {$I 'Form200:impl'}
end;
 
procedure TForm200.Resize;
begin
  inherited;
end;

procedure TForm200.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
  application.display.layoutchildren;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm200);
end.
