unit InvaderJS;
{
    Copyright (c) 2011 Steven Binns

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted to run in Smart Mobile Studio by PPS (2013)
}
interface

uses
  //System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  //SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics;
  W3System, W3Components, W3Application, W3Game, W3GameApp, W3Graphics,
  W3MediaElements,
  Globals, enemies;

type
  TApplication = class(TW3CustomGameApplication)
  private
    FAudioElement: TW3AudioElement;
    level, mousex, mousey : integer;
    timer : integer;
    scoretext : string;
    font : string;
    colour, colour2 : string;
    spawn : Boolean = false;
  protected
    procedure  ApplicationStarting; override;
    procedure  ApplicationClosing; override;
    procedure  PaintView(Canvas: TW3Canvas); override;
    procedure  KeyDownEvent(mCode:integer);
  end;

implementation

procedure TApplication.KeyDownEvent(mCode:integer);
begin
  if mCode=27 then
    Application.Terminate;
end;

procedure TApplication.ApplicationStarting;
begin
  inherited;
  GameView.Delay := 20;
  GameView.Width := 400;
  GameView.Height := 400;
  asm
    window.onkeydown=function(e)
    {
    TApplication.KeyDownEvent(Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  GameView.OnMouseDown := procedure(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer)
    begin
      mousex := x;
      mousey := y;
    end;

  GameView.OnMouseMove := procedure (o : TObject; t : TShiftState; x, y : Integer)
    begin
      mousex := x;
      mousey := y;
    end;

  colour := 'green';
  colour2 := 'black';
  tick := 0;
  score := 1;
  font := '16pt Arial';
  level := 5;
  timer := (level * 300) + 5000;
  FAudioElement := TW3AudioElement.Create;
  FAudioElement.AutoPlay := False;
  FAudioElement.Loop := True;
  if FAudioElement.CanPlayTypeAsBoolean('audio/mpeg') then
    begin
      FAudioElement.Source := 'res/john_stump.mp3';
      FAudioElement.Play;
    end;
  GameView.StartSession(True);
end;

procedure TApplication.ApplicationClosing;
begin
  FAudioElement.Pause;
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);

procedure Draw_Enemies(level: integer);
var
  i : integer;
begin
  for i := 0 to 20 do
    begin
      if mobs[i, 0] = 1 then //if the enemy exists
        begin //draw the enemy body
          Canvas.FillStyle := 'rgba(0, 255, 0, 0.5)';
          Canvas.StrokeStyle := 'rgba(0, 255, 0, 0.5)';
          Canvas.BeginPath;
          Canvas.ArcF(mobsx[i], mobsy[i], mobs[i, 3] DIV 2, 0, PI * 2, true);
          Canvas.ClosePath;
          Canvas.Stroke;
          Canvas.Fill;
          if mobs[i, 4] = 0 then //if the enemy isn't chasing you
            begin  //draw a white aggro circle
              Canvas.FillStyle := 'rgba(255, 255, 255, 0.5)';
              Canvas.StrokeStyle := 'rgba(255, 255, 255, 0.5)';
              Canvas.BeginPath;
              Canvas.ArcF(mobsx[i], mobsy[i], mobs[i, 3], 0, PI * 2, true);
              Canvas.ClosePath;
              Canvas.Stroke;
              Canvas.Fill;
            end
          else if mobs[i, 4] = 1 then //if the enemy is chasing you
            begin  //draw a red aggro circle
              Canvas.FillStyle := 'rgba(150, 0, 0, 0.5)';
              Canvas.StrokeStyle := 'rgba(150, 0, 0, 0.5)';
              Canvas.BeginPath;
              Canvas.ArcF(mobsx[i], mobsy[i], mobs[i, 3], 0, PI * 2, true);
              Canvas.ClosePath;
              Canvas.Stroke;
              Canvas.Fill;
           end;
            if tick = 10 then
              //Increase the score by the combined radii of all the enemies chasing you (divided by 10).
              score := score + mobs[i, 3] DIV 10;
        end;
    end;
end;

begin
  if timer = (level * 300) + 4000 then
    spawn := true;
  // Clear background
  Canvas.FillStyle := 'rgb(0, 0, 0)';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
  scoretext := 'SCORE: ' + inttostr(score);

  // Draw score on the screen
  Canvas.Font := font;
  Canvas.FillStyle := colour;
  Canvas.FillTextF(scoretext, 10, 20, MAX_INT);
  if timer = 0 then
    begin
      level := level + 5;
      timer := (level * 300) + 5000; //after the timer runs out, advance the level
    end;
  enemies.Tick_Enemies(mousex, mousey);
  //draw the character
  Canvas.FillStyle := 'rgba(255, 99, 0, 0.5)';//reddish
  Canvas.StrokeStyle := 'rgba(255, 99, 0, 0.5)';
  Canvas.BeginPath;
  Canvas.ArcF(mouseX, mouseY, level, 0, PI * 2, true);
  Canvas.ClosePath;
  Canvas.Stroke;
  Canvas.Fill;
  Canvas.FillStyle := 'rgba(0, 0, 255, 0.5)';  //blue
  Canvas.StrokeStyle := 'rgba(0, 0, 255, 0.5)';
  Canvas.BeginPath;
  Canvas.ArcF(mouseX, mouseY, level div 5, 0, PI * 2, true);
  Canvas.ClosePath;
  Canvas.Stroke;
  Canvas.Fill;
  //draw enemies
  Draw_Enemies(level);
  if spawn = true then
    begin
      if 100 * random < 10 then
        enemies.Create_Enemy(level);
      //Check collisions between enemies and the character.
      checks.Check_Collisions(level, mousex, mousey);
    end;
  inc(tick);
  if tick = 10 then
    begin
      inc(score);
      tick := 0;
    end;
  timer := timer - 10;
  if stop then
    begin
      Canvas.FillStyle := 'red';
      scoretext := 'SCORE: ' + inttostr(score);
      Canvas.FillTextF(scoretext, 10, 20, MAX_INT);
      Canvas.FillTextF('You were assimilated...', 20, 200, MAX_INT);
      Canvas.FillTextF('Reload (F5) for another game', 20, 300, MAX_INT);
      if FAudioElement.CanPlayTypeAsBoolean('audio/mpeg') then
        FAudioElement.Pause;
      GameView.EndSession;
    end;
end;

end.
