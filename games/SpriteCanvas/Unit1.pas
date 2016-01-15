unit Unit1;

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application, SmartCL.Game,
  SmartCL.GameApp, SmartCL.Graphics, SmartCL.Touch, SmartCL.Controls.Button, SmartCL.Sprite3D;

type
  TCanvasProject = class(TW3CustomGameApplication)
  private
    const SCENE_WIDTH = 300;
    const SCENE_HEIGHT = 250;
    const X_SPEED = 2;
    const Y_SPEED = 2;
    const SPRITE_SCALE_FACTOR = 0.9;
    Mob: TW3Sprite;
    Scene: TRect;
    btnLeft, btnRight, btnUp, btnDown, btnRotX, btnRotY, btnRotZ: TW3Button;
  protected
    procedure SetupGameButton(Btn: TW3Button; Capt: string;
                              W, L, T: integer; var Pressed: Boolean);
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  end;

implementation

var
  MovingLeft, MovingRight, MovingUp, MovingDown, RotatingX, RotatingY, RotatingZ: Boolean;


procedure TCanvasProject.SetupGameButton(Btn: TW3Button; Capt: string;
                                         W, L, T: integer; var Pressed: Boolean);
begin
  Pressed := False;
  Btn.Caption := Capt;
  Btn.Width := W;
  Btn.Left := L;
  Btn.Top := T;
  Btn.OnMouseDown := lambda Pressed := True; end;
  btn.OnMouseUp := lambda Pressed := False; end;
  btn.OnTouchBegin := lambda Pressed := True; end;
  btn.OnTouchEnd := lambda Pressed := False; end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  GameView.Delay := 5;
  Scene := TRect.CreateSized(0, 0, SCENE_WIDTH, SCENE_HEIGHT);

  Mob := TW3Sprite.Create(Document);
  Mob.Background.fromURL('res/GroundEnemy.png');
  Mob.Width := 72;
  Mob.Height := 70;
  Mob.X := 50;
  Mob.Y := 50;
  Mob.SetTransformFlags(CNT_USE_POS or CNT_USE_ROTX or CNT_USE_ROTY or
                        CNT_USE_ROTZ or CNT_USE_SCALE);

  btnLeft := TW3Button.Create(Document);
  SetupGameButton(btnLeft, '←', 40, 5, SCENE_HEIGHT + 5, MovingLeft);
  btnRight := TW3Button.Create(Document);
  SetupGameButton(btnRight, '→', 40, 55, SCENE_HEIGHT + 5, MovingRight);
  btnUp := TW3Button.Create(Document);
  SetupGameButton(btnUp, '↑', 40, 105, SCENE_HEIGHT + 5, MovingUp);
  btnDown := TW3Button.Create(Document);
  SetupGameButton(btnDown, '↓', 40, 155, SCENE_HEIGHT + 5, MovingDown);
  btnRotX := TW3Button.Create(Document);
  SetupGameButton(btnRotX, 'RotateX', 80, SCENE_WIDTH + 5, 0, RotatingX);
  btnRotY := TW3Button.Create(Document);
  SetupGameButton(btnRotY, 'RotateY', 80, SCENE_WIDTH + 5, 50, RotatingY);
  btnRotZ := TW3Button.Create(Document);
  SetupGameButton(btnRotZ, 'RotateZ', 80, SCENE_WIDTH + 5, 100, RotatingZ);
  GameView.StartSession(False);
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
begin
  // Clear background of scene
  Canvas.FillStyle := 'rgb(0, 0, 99)';
  Canvas.FillRectF(Scene);
  // Move mob if button pressed and if a move would not take it outside the scene
  Canvas.FillStyle := 'rgb(99, 0, 0)';
  if MovingLeft and (Mob.X > X_SPEED) then
    Mob.MoveX(-X_SPEED)
  else if MovingRight and (Mob.X + Mob.Width + X_SPEED < SCENE_WIDTH) then
    Mob.MoveX(X_SPEED)
  else if MovingUp and (Mob.Y > Y_SPEED) then
     Mob.MoveY(-Y_SPEED)
  else if MovingDown and (Mob.Y + Mob.Height + Y_SPEED < SCENE_HEIGHT)  then
    Mob.MoveY(Y_SPEED);
  if RotatingX then
    Mob.RotateX(1);
  if RotatingY then
    Mob.RotateY(1);
  if RotatingZ then
    Mob.RotateZ(-1);
  Mob.Scale(SPRITE_SCALE_FACTOR);
  Mob.Update3D;
end;

end.
