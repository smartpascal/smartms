unit ObjectMovingBalls;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses 
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics;

type
  TBall = class(TObject)
  private
     x, y, width, height : float;
     colour : string;
     Speed : integer;
  public
    constructor create(newX, newY, newHeight, newWidth: float; newColour: string; newSpeed : integer);
    procedure move;
  end;

type
  TCanvasProject = class(TW3CustomGameApplication)
  private
    { Private fields and methods }
     i : integer;
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  end;

const
  DELAY = 50;
var
  Ball : array [0..6] of  TBall;
  Timer : integer;

implementation

constructor TBall.create(newX, newY, newHeight, newWidth : float; newColour : string; newSpeed : integer);
begin
  x := newX;
  y := newY;
  height := newHeight;
  width := newWidth;
  colour := newColour;
  speed := newSpeed;
end;

procedure TBall.move;
begin
  if (x < 300 - width) and (y <= 0) then
    x += speed;

  if (x >= 300 - width) and (y < 300 - height) then
    y += speed;

  if (x > 0) and (y >= 300 - height) then
    x -= speed;

  if (y > 0) and (x <= 0) then
    y -= speed;

  if x > 300 - width then
    x := 300 - width;
  if x < 0 then
    x := 0;
  if y < 0 then
    y := 0;
  if y > 300 - height then
    y := 300 - height;
end;

{ TCanvasProject }

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  GameView.Delay := 20;
  Timer := 0;
                         //newX, newY, newHeight, newWidth, newColour, newSpeed
  Ball[0] := TBall.create(- DELAY, 0, DELAY - 10, DELAY - 10, 'red', 1);
  Ball[1] := TBall.create(- DELAY * 2, 0, DELAY - 10, DELAY - 10, 'orange', 2);
  Ball[2] := TBall.create(- DELAY * 3, 0, DELAY - 10, DELAY - 10, 'yellow', 3);
  Ball[3] := TBall.create(- DELAY * 4, 0, DELAY - 10, DELAY - 10, 'green', 4);
  Ball[4] := TBall.create(- DELAY * 5, 0, DELAY - 10, DELAY - 10, 'blue', 5);
  Ball[5] := TBall.create(- DELAY * 6, 0, DELAY - 10, DELAY - 10, 'purple', 6);
  Ball[6] := TBall.create(- DELAY * 7, 0, DELAY - 10, DELAY - 10, 'rgb(153, 50, 204)', 7);
  GameView.StartSession(True);
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;
 
// Note: In a real live game you would try to cache as much
// info as you can. Typical tricks are: 
//   1: Only get the width/height when resized
//   2: Pre-calculate strings, especially RGB/RGBA values
//   3: Only redraw what has changed, avoid a full repaint
// The code below is just to get you started
 
procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
begin
  if Timer = 0 then
    begin
      // Clear background
      Canvas.FillStyle := 'white';
      Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
    end;
  while i <= 6 do
    begin
      Canvas.FillStyle := (Ball[i].colour);
      Canvas.BeginPath;
      Canvas.Ellipse(Ball[i].x, Ball[i].y, Ball[i].x + Ball[i].width, Ball[i].y + Ball[i].height);
      Canvas.ClosePath;
      Canvas.Fill;
      Ball[i].move;
      inc(i);
    end;
  i := 0;
  Timer += 1;
end;

end.