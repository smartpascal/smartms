unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button;

type
  TForm1 = class(TW3Form)
    procedure W3Button1Click(Sender: TObject);
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;

implementation

uses Unit1;

{ TForm1 }

procedure TForm1.W3Button1Click(Sender: TObject);
begin
 Application.gotoForm('Form200',feToLeft);
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
end;
 
procedure TForm1.Resize;
begin
  inherited;
end;

procedure TForm1.FormActivated;
Begin
  inherited;
  TApplication(application).Header.Title.Caption:='Getting Started';
  TApplication(application).Header.Backbutton.StyleClass := 'ios-6-arrow left blue';
  TApplication(application).Header.Backbutton.Caption := '';
  TApplication(application).Header.Backbutton.Handle.setAttribute("data-title","Back");
  TApplication(application).Header.Width:=TApplication(application).Header.Width +1;
  TApplication(application).Header.Width:=TApplication(application).Header.Width -1;
  TApplication(application).BackNextButton; // Show Back and Next button
  TApplication(application).Header.Backbutton.visible:=False;
  Application.display.layoutchildren;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.