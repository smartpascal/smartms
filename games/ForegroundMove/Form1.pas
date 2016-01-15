unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Sprite3D, SmartCL.Time;

type
  TFront = class(TW3Sprite)
  protected
    procedure InitializeObject; override;
  public
    procedure UpdateBehavior(const TimeId: integer); override;
  end;

  TForm1 = class(TW3form)
  private
    {$I 'Form1:intf'}
    FFront : TFront;
    FTimer : TW3Timer;
    FCounter : integer;
  protected
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure Resize; override;
    procedure HandleUpdate(Sender: TObject);
  end;

implementation

{ TFront}

procedure TFront.InitializeObject;
begin
  inherited;
  SetTransformFlags(CNT_USE_POS);
  Background.fromURL('res/tile_ground.png');
  Width := 96 * 32;
  Height := 96;
  Transparent := True;
end;

procedure TFront.UpdateBehavior(Const TimeId: integer);
var
  mRange: Integer;
begin
  mRange := Application.Display.View.Width;
  mRange := (mRange div 96) * 96;
  if X <= -(mRange) then
    X := 0.0;
  MoveX(-1.5);
  Update3d;
end;

{ TForm1}

procedure TForm1.HandleUpdate(Sender: TObject);
begin
  Inc(FCounter);
  FFront.UpdateBehavior(FCounter);
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  FFront := TFront.Create(self);
  FTimer := TW3Timer.Create;
  FTimer.Delay := 1;
  FTimer.onTime := HandleUpdate;
  FTimer.Enabled := True;
end;

procedure TForm1.FinalizeObject;
begin
  FFront.Free;
  inherited;
end;

procedure TForm1.Resize;
begin
  inherited;
  FFront.SetBounds(0, Height - FFront.Height, FFront.Width, FFront.Height);
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);

end.