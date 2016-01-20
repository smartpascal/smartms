unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Layout,
  SmartCL.Controls.ToggleSwitch, SmartCL.Controls.Panel, SmartCL.Controls.Memo,
  SmartCL.Controls.Label, SmartCL.Controls.Elements;

type
  TForm1 = class(TW3Form)
    procedure W3ToggleSwitch1Changed(Sender: TObject);
  private
    {$I 'Form1:intf'}
    FLayout: TLayout;
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

procedure TForm1.W3ToggleSwitch1Changed(Sender: TObject);
begin
  if W3ToggleSwitch1.Checked then
     W3Memo1.Zoom := W3Panel1.Width / W3Memo1.Width
  else
    W3Memo1.Zoom := 1;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  W3Memo1.Text := 'The default font for the memo might be a bit small for those with impaired vision. The toggle switch controls the zoom.';
  W3Memo1.ScrollH :=  soNone;
  W3Memo1.ScrollV :=  soNone;
  W3Label1.Font.Size := 14;

  FLayout := Layout.Client(Layout{1}.Margins(20).Spacing(5), [
      Layout{2}.Top(W3Panel1),
      Layout{3}.Top(CONTAINER)
    ]);
end;

procedure TForm1.Resize;
begin
  inherited;
  FLayout.Resize(Self);
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
