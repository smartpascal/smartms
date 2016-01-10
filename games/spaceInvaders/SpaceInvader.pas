unit SpaceInvader;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics,
  Items, Settings, Input;

type
  TMode = (Main, GameOver);

TApplication = class(TW3CustomGameApplication)
  private
    Items: Array of TItem;
    Start, LastBulletCreated: TDateTime;
    Mode: TMode;
    PressingSpace: Boolean;
    Score: Integer;
    procedure AddNewEnemy;
    procedure AddNewBullet;
    function CheckIfNewEnemy: Boolean;
    procedure ClearScreen(Canvas: TW3Canvas);
    procedure PaintMain(Canvas: TW3Canvas);
    procedure PaintGameOver(Canvas: TW3Canvas);
    procedure SetupGame;
    function CreateBullet: Boolean;
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  public
    procedure KeyDown(mCode: Integer);
    procedure KeyUp(mCode: Integer);
  end;

const
  SQUARE_SIZE = 200;

implementation

procedure TApplication.SetupGame;
begin
  Start := Now;
  Mode := Main;
  Items.Clear;
  Items[0] := TPlayer.Create(20, 20, GameView.Width div 2, GameView.Height - 30);
  Score := 0;
end;

procedure TApplication.AddNewEnemy;
begin
  Items.Add(TEnemy.Create(20, 10, Floor(Random * GameView.Width), 0));
end;

function TApplication.CheckIfNewEnemy: Boolean;
begin
  Result := Random < ((Now - Start) * ENEMY_CREATION_MULTIPLIER +
                      ENEMY_CREATION_SPEED * GameView.Width);
end;

procedure TApplication.ClearScreen(Canvas: TW3Canvas);
var
  StartColour: String;
begin
  StartColour := Canvas.FillStyle;
  Canvas.FillStyle := 'black';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
  Canvas.FillStyle := StartColour;
end;

// Note: In a real live game you would try to cache as much
// info as you can. Typical tricks are:
//   1: Only get the width/height when resized
//   2: Pre-calculate strings, especially RGB/RGBA values
//   3: Only redraw what has changed, avoid a full repaint
// The code below is just to get you started

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
/*
  // Clear background
  Canvas.FillStyle := 'rgb(0, 0, 99)';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);

  // Draw our framerate on the screen
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'rgb(255, 255, 255)';
  Canvas.FillTextF('FPS:' + IntToStr(GameView.FrameRate), 10, 20, MAX_INT);
*/
  case Mode of
    Main: PaintMain(Canvas);
    GameOver: PaintGameOver(Canvas);
  end;
end;

procedure TApplication.PaintGameOver(Canvas: TW3Canvas);
begin
  ClearScreen(Canvas);
  if Score = 0 then Score := Round(1000000 * (Now - Start));
  Canvas.FillText('GAME OVER!', 50, 50);
  Canvas.FillText('Score: '+ FloatToStr(Score), 50, 70);
end;

procedure TApplication.PaintMain(Canvas: TW3Canvas);
var
  I, J: Integer;
  ToDelete: Array of TItem; //deleting while we loop messes things up
begin
  if CheckIfNewEnemy then AddNewEnemy;
  if CreateBullet then AddNewBullet;

  for I := Low(Items) to High(Items) do begin
    Items[I].UpdatePosition;
    //Check if still on screen
    if not Items[I].IsOnScreen(GameView.Height) then ToDelete.Add(Items[I])
    else begin
      //Check if it has collided with anything
      for J := I + 1 to High(Items) do begin
        if Items[I].CheckCollision(Items[J]) then begin
          Log('Items ' + IntToStr(I) + ' and ' + IntToStr(J) + ' collided');
          if I = 0 then begin //player has been hit!
            Mode := GameOver;
            Exit;
          end else begin
            //collisions mean we delete object from game
            ToDelete.Add(Items[I]);
            ToDelete.Add(Items[J]);
          end;
        end;
      end;
    end;
  end;
  for I := Low(ToDelete) to High(ToDelete) do Items.Remove(ToDelete[I]);

  ClearScreen(Canvas);
  for I := Low(Items) to High(Items) do begin
    Items[I].Draw(Canvas);
  end;
end;

procedure TApplication.KeyDown(mCode: Integer);
begin
  if mCode = 32 then PressingSpace := True;
end;

procedure TApplication.KeyUp(mCode: Integer);
begin
  if mCode = 32 then PressingSpace := False;
end;

procedure TApplication.AddNewBullet;
begin
  Items.Add(TBullet.Create(10, 10, Items[0].Left + 5, Items[0].Top - 15));
  LastBulletCreated := Now;
end;

function TApplication.CreateBullet: Boolean;
begin
  Log(FloatToStr(Now - LastBulletCreated));
  Result := PressingSpace and (Now - LastBulletCreated > BULLET_INTERVAL)
end;

procedure TApplication.ApplicationStarting;
begin
  inherited;
  // Initialize refresh interval, set this to 1 for optimal speed
  GameView.Delay := 20;
  // Start the redraw-cycle with framecounter active
  // Note: the framecounter impacts rendering speed. Disable
  // the framerate for maximum speed (false)
  GameView.StartSession(True);
  asm
    window.onkeydown=function(e)
    {
    (@KeyDownEvent)(e.keyCode);
    }
    window.onkeyup=function(e)
    {
    (@KeyUpEvent)(e.keyCode);
    }
  end;
  AddKeyDown(KeyDown);
  AddKeyUp(KeyUp);
  SetupGame;
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

end.