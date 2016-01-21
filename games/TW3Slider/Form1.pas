unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Panel,
  SmartCL.Slider, SmartCL.Controls.Label;

type
  TForm1 = class(TW3Form)
    procedure W3Slider1Change(Sender: TObject);
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.W3Slider1Change(Sender: TObject);
begin
  var angle := W3Slider1.Value;
  W3Label1.Angle := angle;
  var intAngle := round(angle);
  W3Label1.Caption := 'Angle: ' + intToStr(intAngle);
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  W3Label1.Font.Size := 16;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
