unit Form2;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button,
  SmartCL.Controls.Label, SmartCL.Controls.Header, SmartCL.Layout,
  SmartCL.Controls.Memo;

type
  TForm2 = class(TW3Form)
  private
    {$I 'Form2:intf'}
    FLayout: TLayout;
    procedure W3Button1Click(Sender: TObject);
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure FormDeactivated; override;
    procedure Resize; override;
  end;

implementation

{ TForm2 }

procedure TForm2.W3Button1Click(Sender: TObject);
begin
	Application.GotoForm('Form1', feFromRight{feToLeft});
end;

procedure TForm2.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
  W3Memo1.Text := #"
    Correct way to use the Layout Manager:
      - Create the layout in InitializeForm.
      - Reposition components in Resize.
      - Destroy the layout in FormDeactivate event.";
  W3Memo1.Enabled := false;

  FLayout := Layout.Client(Layout.Spacing(3),
               [
                 Layout.Top([W3Label1, W3Button1]),
                 Layout.Client(W3Memo1)
               ]);
end;

procedure TForm2.InitializeObject;
begin
  inherited;
  {$I 'Form2:impl'}
end;
 
procedure TForm2.Resize;
begin
  inherited;
  if assigned(FLayout) then
    FLayout.Resize(Self);
end;
 
procedure TForm2.FormDeactivated;
begin
  inherited;
  //FLayout := nil;
  WriteLn('FormDeactivated2');
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm2);
end.
