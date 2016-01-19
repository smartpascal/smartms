unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Controls.SimpleLabel,
  SmartCL.Controls.Listbox, System.Colors, System.Types, RadioButton,
  SmartCL.Controls.Panel;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    W3Label1: TW3Label;
    Label1: TW3SimpleLabel;
    const Colours: array[0..4] of TColor = [clRed, clOrange, clYellow, clGreen, clBlue];
    const strColours: array[0..4] of string = ['Red', 'Orange', 'Yellow', 'Green', 'Blue'];
    rbSmall, rbMedium, rbLarge: TW3RadioButton;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.InitializeForm;
begin
  inherited;
  rbSmall := new TW3RadioButton(self);
  rbSmall.SetBounds(10, 230, 120, 50);
  rbSmall.Checked := False;
  rbSmall.Caption := 'Small text';
  rbSmall.OnClick := procedure(sender: TObject)
    begin
      Label1.Font.Size := 10;
      rbMedium.Checked := False;
      rbLarge.Checked := False;
    end;

  rbMedium := new TW3RadioButton(self);
  rbMedium.SetBounds(10, 260, 120, 50);
  rbMedium.Checked := False;
  rbMedium.Caption := 'Medium text';
  rbMedium.OnClick := procedure(sender: TObject)
    begin
      Label1.Font.Size := 14;
      rbSmall.Checked := False;
      rbLarge.Checked := False;
    end;

  rbLarge := new TW3RadioButton(self);
  rbLarge.SetBounds(10, 290, 120, 50);
  rbLarge.Checked := True;
  rbLarge.Caption := 'Large text';
  rbLarge.OnClick := procedure(sender: TObject)
    begin
      Label1.Font.Size := 18;
      rbSmall.Checked := False;
      rbMedium.Checked := False;
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  Label1 := TW3SimpleLabel.Create(Self);
  Label1.Autosize := true;
  Label1.Caption := 'Please select text colour and size.';
  Label1.Font.Color := clRed;
  Label1.Font.Size := 18;

  W3ListBox1.ItemClass := TW3Label;
  W3ListBox1.Handle.style.setProperty('background-color', 'rgb(0, 173, 240)');
  for var i := 1 to 5 do
  W3ListBox1.Add;
  W3ListBox1.Styles.SelectedColor := clLightBlue;
  W3ListBox1.SelectedIndex := 0;
  W3ListBox1.EnableAnimation := false;
  W3ListBox1.OnSelected := procedure (sender: TObject; idx: integer)
    begin
      Label1.Font.Color := Colours[idx];
    end;
  for var i := 0 to 4 do begin
    TW3Label(W3ListBox1.Items[i]).Caption:= strColours[i];
  end;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
