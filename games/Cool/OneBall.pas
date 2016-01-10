unit OneBall;
{
    Copyright (c) 2015 Dom

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics;

type
  TCanvasProject = class(TW3CustomGameApplication)
  public
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure KeyDownEvent(mCode: integer);
    procedure Shoot;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure NewEnemy;
  end;

implementation

const
  MOB_WIDTH = 20;
  MOB_HEIGHT = 20;

var
  MobX: integer; //Distance of mobile from left of GameView
  GoingRight, GoingDown: Boolean;
  MobY, EnemyX, EnemyY, BulletX, BulletY, Score, Health: integer;
  Rank: string = 'Beginner';
  Colour: string = 'red';
  IntersectRect: TRect;
  direction: string = 'ShootUp';
  EnemyColour: string = 'blue';
  DirectionFacing: string = 'Up';

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  randomize;
  GoingRight := True;
  GoingDown := True;
  MobX := 50;
  MobY := 100;
  EnemyX := RandomInt(GameView.Width);
  EnemyY := RandomInt(GameView.Height);
  BulletX := -60;
  Health := 3;
  asm
    window.onkeydown=function(e)
    {
    TCanvasProject.KeyDownEvent(Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  GameView.Delay := 1;
  GameView.StartSession(True);
end;

procedure TCanvasProject.KeyDownEvent(mCode : integer);
begin
  case mCode of
    27: Application.Terminate;
    37, 65: begin
              dec(MobX, 20);
              DirectionFacing := 'Left'
            end;
    38, 87: begin
              dec(MobY, 20);
              DirectionFacing := 'Up'
            end;
    39, 68: begin
              inc(MobX, 20);
              DirectionFacing := 'Right'
            end;
    40, 83: begin
              inc(MobY, 20);
              DirectionFacing := 'Down'
            end;
    32, 81: begin
              if DirectionFacing = 'Up' then
                direction := 'ShootUp';
              if DirectionFacing = 'Right' then
                direction := 'ShootRight';
              if DirectionFacing = 'Down' then
                direction := 'ShootDown';
              if DirectionFacing = 'Left' then
                direction := 'ShootLeft';
              Shoot;
            end;
  end;
end;

procedure TCanvasProject.NewEnemy;
begin
  EnemyX := RandomInt(GameView.Width);
  EnemyY := RandomInt(GameView.Height);
  Score += 1;
  case Score of
    0..9: Rank := 'Beginner';
    10..19: Rank := 'Apprentice';
    20..29: Rank := 'Soldier';
    30..39: Rank := 'Master';
    40..max_Int: Rank := 'God';
  end;
end;

procedure TCanvasProject.Shoot;
begin
  BulletX := MobX + 10;
  BulletY := MobY + 10;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
begin
  if Rank = 'Beginner' then
    Colour := 'Red';
  if Rank = 'Apprentice' then
    Colour := 'Blue';
  if Rank = 'Soldier' then
    Colour := 'Green';
  if Rank = 'Master' then
    Colour := 'Yellow';
  if Rank = 'God' then
    Colour := 'Gold';
  // Clear background with colour teal.
  Canvas.FillStyle := 'teal';
  Canvas.FillRect(0, 0, GameView.Width, GameView.Height);
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'black';
  Canvas.FillText('Score: ' + inttostr(Score) + '   Rank: ', 10, 20);
  Canvas.FillStyle := Colour;
  Canvas.FillText(Rank, 140, 20);
  //Draw circle.
  Canvas.FillStyle := Colour;
  Canvas.BeginPath;
  Canvas.Ellipse(MobX, MobY, MobX + MOB_WIDTH, MobY + MOB_HEIGHT);
  Canvas.Fill;
  Canvas.FillRect(BulletX, BulletY, 5, 5);
  if BulletX > 0 then
    case direction of
      "ShootRight": inc(BulletX, 20);
      "ShootLeft": inc(BulletX, -20);
      "ShootUp": inc(BulletY, -20);
      "ShootDown": inc(BulletY, 20);
    end;

  var BulletRect := TRect.Create(BulletX, BulletY, BulletX + 10, BulletY + 5);
  var EnemyRect := TRect.Create(EnemyX, EnemyY, EnemyX + 20, EnemyY + 20);
  if BulletRect.Intersect(EnemyRect, IntersectRect) then
    begin
      Health -= 1;
      BulletX := -100000; // Safely off the screen!
    end;
  if Health = 0 then
    begin
      Health := 3;
      NewEnemy;
    end;

  if Health = 2 then
    EnemyColour := 'black';
  if Health = 1 then
    EnemyColour := 'red';
  if Health = 3 then
    EnemyColour := 'blue';
  //Test for collision between mobile and enemy of the same size (20)
  if not ((abs(MobX - EnemyX) <= 20) and (abs(MobY - EnemyY) <= 20)) then
    begin
      Canvas.FillStyle := EnemyColour;
      Canvas.FillRect(EnemyX, EnemyY, 20, 20);
    end
  else
    NewEnemy;
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

end.