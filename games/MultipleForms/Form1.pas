unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Controls, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label;

type
  TForm1 = class(TW3form)
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
end;

implementation

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  W3HeaderControl1.Title.Caption := 'Form1 Header';
  W3HeaderControl1.NextButton.Visible := true;
  W3HeaderControl1.NextButton.OnClick := procedure (Sender: TObject)
    begin
      Application.GotoForm('Form2', feFromRight);
    end;
  W3HeaderControl1.BackButton.Visible := false;
end;

procedure TForm1.Resize;
begin
  inherited;
  W3HeaderControl1.Width := ClientWidth;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
