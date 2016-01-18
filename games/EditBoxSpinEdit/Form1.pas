unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.EditBox,
  SmartCL.Controls.Memo, SmartCL.Controls.Label;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.InitializeObject;
var
  fontSize: integer;

  procedure SetFontSize;
    begin
      fontSize := strToInt(W3EditBox1.Text);
      if fontSize in [12 .. 18] then
        W3Memo1.Font.Size := fontSize;
    end;

begin
  inherited;
  {$I 'Form1:impl'}
  W3Memo1.Text := 'The TW3Edit''s InputType is itNumber and the min and max for control' +
                  '  by the up and down clicks are set to be 12 and 18, respectively.';
  W3EditBox1.InputType := itNumber;
  W3EditBox1.setMax(18);
  W3EditBox1.setMin(12);
  W3EditBox1.Text := '12';
  W3Memo1.Font.Size := 12;
  W3Memo1.ScrollH := soNone;
  W3Memo1.ScrollV := soNone;
  var oldValue:= W3EditBox1.Value;
  W3EditBox1.OnChanged := procedure (aValue: TObject)
  begin
    oldValue := W3EditBox1.Value;
  end;
  W3EditBox1.OnKeyUp := procedure (Sender: TObject; aKeyCode: integer)
    begin
      if not (aKeyCode in [8, 48 .. 57, 96 .. 105]) then
      begin
        showMessage('Digits only!');
        W3EditBox1.Value := oldValue;
       end
      else
        begin
          SetFontSize;
          if fontSize > 18 then
            begin
              W3EditBox1.Text := '18';
              W3Memo1.Font.Size := 18;
            end;
        end;
    end;
  W3EditBox1.OnClick := procedure (Sender: TObject)
    begin
      SetFontSize;
    end;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);

end.