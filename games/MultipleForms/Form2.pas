unit Form2;

interface

uses
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Controls.Header;

type
  TForm2 = class(TW3form)
  private
   {$I 'Form2:intf'}
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

procedure TForm2.InitializeObject;
begin
  inherited;
   {$I 'Form2:impl'}
   W3HeaderControl1.Title.Caption := 'Form 2 Header';
   W3HeaderControl1.NextButton.Visible := true;
   W3HeaderControl1.NextButton.OnClick := procedure (Sender: TObject)
     begin
       Application.GotoForm('Form3', feFromRight);
     end;
   W3HeaderControl1.BackButton.Visible := true;
   W3HeaderControl1.BackButton.OnClick := procedure (Sender: TObject)
     begin
       Application.GotoForm('Form1', feToLeft);
     end;
end;

procedure TForm2.Resize;
begin
  inherited;
  W3HeaderControl1.Width := ClientWidth;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm2);
end.
