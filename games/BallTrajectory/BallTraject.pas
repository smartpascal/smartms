unit BallTraject;
{
    Copyright (c) 2014 Felix Thompson

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System, W3Components, W3Application, W3Game, W3GameApp, W3Graphics;

type
  TApplication = class(TW3CustomGameApplication)
  protected
    procedure  ApplicationStarting; override;
    procedure  ApplicationClosing; override;
    procedure  PaintView(Canvas: TW3Canvas); override;
  end;

implementation

{ TApplication}

var
  t : Integer;
  mX, mY, vX, vY : Real;

procedure TApplication.ApplicationStarting;
begin
  inherited;
  GameView.Delay := 20;
  GameView.StartSession(True);
  mX := 150;                               // The ball starts in the centre of the
  mY := 150;                               // screen after each refresh.
  vX := (100 - RandomInt(200));            // A random vertical and
  vY := 20* (10 - RandomInt(20));          // horizontal velocity is chosen.
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  Canvas.FillStyle := 'white';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height); //The screen in drawn with edges.
  Canvas.FillStyle := 'Black';
  Canvas.FillRectF(0, 299 , 300, 1);
  Canvas.FillStyle := 'Black';
  Canvas.FillRectF(299, 0, 1, 300);
  Canvas.FillStyle := 'Black';
  Canvas.FillRectF(0, 0 , 300, 1);
  Canvas.FillStyle := 'Black';
  Canvas.FillRectF(0, 0, 1, 300);

  t += 1;
  vY := vY - 0.2 * t;           //Vertical velocity always increases downwards - gravity.
  mY -= 0.1 * vY;               //The speeds are added to the current location
  mX -= 0.1 * vX;               //to give the new position.

  if mY + 10 >= 300 then        //This stops the ball from going underground,
    begin                       //it reverses its direction on collision and
      vy := -vY * 0.9;          //loses a factor of its speed - restitution.
      mY := 290;
    end;
  if mY - 10 <= 0 then
    begin
      vy := -vY * 0.9;
      mY := 10;
    end;
  if (mX + 10 >= 300) AND (Abs(vX) > 0.01) then
    begin
      vX := -vX * 0.9;
      mX := 290;
    end;                        //The same happens here but for the walls.
  if (mX - 10 <= 0) AND (Abs(vX) > 0.01) then
    begin
      vX := -vX * 0.9;
      mX := 10;
    end;                        //If the ball is on the ground it loses
  if (mY = 290) then            //horizontal speed - friction.
    begin
      vX := vX * 0.95;
    end;

  Canvas.FillStyle := 'Black';  //The ball is drawn
  Canvas.BeginPath;
  Canvas.Ellipse(Round(mX) + 10, Round(mY) + 10, Round(mX) -10, Round(mY) - 10);
  Canvas.Fill;
  Canvas.ClosePath;
end;

end.
