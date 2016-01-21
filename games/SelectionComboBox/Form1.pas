unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.ComboBox,
  System.Colors, System.Types, SmartCL.Controls.Label, SmartCL.Controls.EditBox;

type
  TForm1 = class(TW3Form)
    procedure edtColourKeyUp(Sender: TObject; aKeyCode: Integer);
  private
    {$I 'Form1:intf'}
  const strColours: array [1 .. 24] of string = ('maroon', 'olive', 'navy', 'purple',
                                                 'teal', 'green', 'gray', 'silver',
                                                 'lime', 'yellow', 'fuchsia', 'red',
                                                 'aqua', 'lightgray', 'darkgray', 'white',
                                                 'moneygreen', 'blue', 'skyblue', 'cream',
                                                 'mediumgray', 'black', 'orange', 'pink');

  const intColours: array [1 .. 24] of TColor = (clMaroon, clOlive, clNavy, clPurple,
                                                 clTeal, clGreen, clGray, clSilver,
                                                 clLime, clYellow, clFuchsia, clRed,
                                                 clAqua, clLightGray, clDarkGray, clWhite,
                                                 clMoneyGreen, clBlue, clSkyBlue, clCream,
                                                 clMedGray, clBlack, clOrange, clPink);
  protected
    procedure InitializeObject; override;
    function ColourValue(Colour: string): integer;
  end;

implementation

function TForm1.ColourValue(Colour: string): integer;
var
  i : integer;
  Found : Boolean;
begin
  i := 0;
  Found := False;
  repeat
    inc(i);
    if Colour = strColours[i] then
      begin
        Found := True;
        result := intColours[i];
      end;
  until (i = 24) or Found;
  if not Found then
    result := -1;
end;

procedure TForm1.edtColourKeyUp(Sender: TObject; aKeyCode: Integer);
begin
  var intColour := ColourValue(edtColour.text);
  if  intColour <> -1 then  // If it is one of our allowed colours
    begin
      W3Label1.Font.Color := TColor(intColour);
      var idx := cboColours.indexOf(lowerCase(edtColour.text));
      if idx = -1 then // not already present so add it
        begin
          cboColours.Add(lowerCase(edtColour.text));
          cboColours.Values[cboColours.Count - 1] := intColour;
          cboColours.SelectedIndex := cboColours.Count - 1;
        end
      else //is present so set it to be selected
        cboColours.SelectedIndex := idx;
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  cboColours.Add('red');
  cboColours.Values[0] := clRed;
  cboColours.Add('green');
  cboColours.Values[1] := clGreen;
  cboColours.Add('blue');
  cboColours.Values[2] := clBlue;
  cboColours.OnChanged := procedure(Sender: TObject)
    begin
      W3Label1.Font.Color := cboColours.Values[cboColours.SelectedIndex];
    end;
  W3Label1.Caption := 'Please select or type a colour.';
  W3Label1.Font.Color := clRed;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
