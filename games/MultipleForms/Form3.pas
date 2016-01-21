unit Form3;

interface

uses
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Controls.Header;

type
  TForm3 = class(TW3form)
  private
    {$I 'Form3:intf'}
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

procedure TForm3.InitializeObject;
begin
  inherited;
  {$I 'Form3:impl'}
  W3HeaderControl1.Title.Caption := 'Form3 Header';
  W3HeaderControl1.NextButton.Visible := false;
  W3HeaderControl1.BackButton.Visible := true;
  W3HeaderControl1.BackButton.OnClick := procedure (Sender: TObject)
    begin
      Application.GotoForm('Form2', feToLeft);
    end;
end;

procedure TForm3.Resize;
begin
  inherited;
   W3HeaderControl1.Width := ClientWidth;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm3);
end.
