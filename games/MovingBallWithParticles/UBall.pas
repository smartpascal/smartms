unit UBall;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  SmartCL.System, SmartCL.Graphics, UEmitter, UColourShifter;

type TBall = class(TObject)
  X : float; // The x position
  Y : float; // The y position
  Width : float; // The width of the ball
  Height : float; // The height of the ball
  XSpeed : float; // The x speed of the ball
  YSpeed : float; // The y speed of the ball
  Emitter : TParticleEmitter; // The particle emitter
  ColourShifter : TColourShifter; // The colour changer
  constructor Create(newX, newY, newWidth, newHeight, newXSpeed, newYSpeed : float);
  procedure Update(screenWidth, screenHeight : float);
  procedure Draw(Canvas : TW3Canvas);
end;

implementation

constructor TBall.Create(newX, newY, newWidth, newHeight, newXSpeed, newYSpeed : float);
begin
  X := newX;
  Y := newY;
  Width := newWidth;
  Height := newHeight;
  XSpeed := newXSpeed;
  YSpeed := newYSpeed;
  Emitter := TParticleEmitter.Create(X, Y);
  ColourShifter := TColourShifter.Create(175, 0, 0);
end;

procedure TBall.Update(screenWidth, screenHeight : float);
begin
  // Move the ball
  X += XSpeed;
  Y += YSpeed;
  // Check for x bounce
  if (X <= 0) or (X + Width >= screenWidth) then
    XSpeed := -XSpeed;
  // Check for y bounce
  if (Y <= 0) or (Y + Height >= screenHeight) then
    YSpeed := -YSpeed;
  // Update the particles
  Emitter.Update(X, Y, 2);
end;

procedure TBall.Draw(Canvas : TW3Canvas);
begin
  // Draw the particles
  Emitter.DrawStars(Canvas);
  // Set the fillstyle
  Canvas.FillStyle := ColourShifter.RGBString;
  Canvas.StrokeStyle := 'black';
  // Design the ball
  Canvas.BeginPath;
  Canvas.Ellipse(X, Y, X + Width, Y + Height);
  // Draw the ball
  Canvas.Fill;
  Canvas.Stroke;
  // Shift the colour
  ColourShifter.ShiftColour(2.055);
end;

end.
