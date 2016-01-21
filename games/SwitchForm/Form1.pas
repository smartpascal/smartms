unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Layout,
  SmartCL.Controls.Header, SmartCL.Controls.Button, SmartCL.Controls.Label,
  SmartCL.Controls.Image, SmartCL.Controls.CheckBox,
  SmartCL.Controls.ToggleSwitch;

const
  MAXCOUNT = 3;

type
  TForm1 = class(TW3Form)
  private
{$I 'Form1:intf'}
    fLayout: TLayout;
    fCount: Integer;
  protected
    procedure BackClick(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure LoadImage;
    procedure UpdateBtns;
  end;

implementation

{ TForm1 }

procedure TForm1.LoadImage;
begin
  W3Image1.LoadFromURL('res\' + intToStr(fCount) + '.jpg');
end;

procedure TForm1.UpdateBtns;
begin
  W3Button1.Enabled := fCount > 1;
  W3Button1.Visible := fCount > 1;

  W3Button2.Enabled := fCount < MAXCOUNT;
  W3Button2.Visible := fCount < MAXCOUNT;
end;

procedure TForm1.BackClick(Sender: TObject);
begin
  dec(fCount);
  LoadImage;
  UpdateBtns;
end;

procedure TForm1.NextClick(Sender: TObject);
begin
  inc(fCount);
  LoadImage;
  UpdateBtns;
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  fCount := 1;
  // this is a good place to initialize components
  LoadImage;
  UpdateBtns;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
{$I 'Form1:impl'}
  fCount := 1;
  W3HeaderControl1.BackButton.Visible := False;
  W3HeaderControl1.Title.AlignText := taCenter;
  W3HeaderControl1.Title.Caption := 'Switch';
  W3HeaderControl1.Height := 50;

  W3Button1.Caption := 'Back';
  W3Button1.OnClick := BackClick;

  W3Button2.Caption := 'Next';
  W3Button2.OnClick := NextClick;

  fLayout := Layout.Client(Layout.Margins(10).Spacing(10),
    [Layout.Top(W3HeaderControl1),

    Layout.Client(

    Layout.Center(W3Image1)

    ),

    Layout.Bottom(Layout.Height(50), [Layout.Left(W3Button1),
    Layout.Right(W3Button2)])]);
end;

procedure TForm1.Resize;
begin
  inherited;
  fLayout.Resize(Self);
end;

initialization

Forms.RegisterForm({$I %FILE%}, TForm1);

end.
