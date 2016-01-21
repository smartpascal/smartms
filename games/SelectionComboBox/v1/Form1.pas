unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.ComboBox,
  System.Colors, SmartCL.Controls.Label;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  cboColours.Add('Red');
  cboColours.Add('Green');
  cboColours.Add('Blue');
  cboColours.OnChanged := procedure(Sender: TObject)
    begin
      case cboColours.SelectedIndex of
        0: W3Label1.Font.Color := clRed;
        1: W3Label1.Font.Color := clGreen;
        2: W3Label1.Font.Color := clBlue;
      end;
    end;
  W3Label1.Caption := 'Please select a colour.';
  W3Label1.Font.Color := clRed;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
