unit UParticle;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  SmartCL.System, SmartCL.Graphics;

type TParticle = class(TObject)
   X : float; // The X position of this particular particle
   Y : float; // The Y position of this particular particle
   Xvol : float; // How fast it is moving in the X direction
   Yvol : float; // How fast it is moving in the Y direction
   Angle : float; // The angle it is rotated to
   Spin : float; // How much spin it has, will be added to the angle
   Colour : array [0..2] of integer; // The R, G, B values to be used to form a colour
   Size : float; // The size multiplier
   TTL : integer; // TTL = Time To Live; when it reaches 0 it will be killed off by the emitter
   constructor Create(newx, newy, newxvol, newyvol, newangle, newspin, newsize : float; newcolour : array [0..2] of integer; newttl : integer);
   procedure Update;
   procedure Draw(Canvas : TW3Canvas);
end;

implementation

constructor TParticle.Create(newx, newy, newxvol, newyvol, newangle, newspin, newsize : float; newcolour : array [0..2] of integer; newttl : integer);
begin
  X := newx;
  Y := newy;
  Xvol := newxvol;
  Yvol := newyvol;
  Angle := newangle;
  Spin := newspin;
  Colour := newcolour;
  Size := newsize;
  TTL := newttl;
end;

procedure TParticle.Update();
begin
  dec(TTL); // Decreasing its time left, meaning it can be terminated at 0
  X += Xvol; // Adds the Xvol to the x so it moves
  Y += Yvol; // Adds the Yvol to the y so it moves
  Angle += Spin; // Adds the Spin to the angle so it appears to spin
end;

procedure TParticle.Draw(Canvas : TW3Canvas);
begin
  // Sets the Fillstyle
  Canvas.FillStyle := 'rgb(' + IntToStr(Colour[0]) + ', ' +
                           IntToStr(Colour[1]) + ', ' + IntToStr(Colour[2]) + ')';

  // Set 0, 0 point to the centre of the star
  Canvas.Translate((10 * Size) + X, (10 * Size) + Y);
  // Rotate the star
  Canvas.Rotate(Angle * PI / 180);
  // Restore the 0, 0 point back to 0, 0
  Canvas.Translate(-((10 * Size) + X), -((10 * Size) + Y));
  // Draw the 5-point star
  Canvas.BeginPath();
  Canvas.MoveToF((10 * Size) + X, (0 * Size) + Y);
  Canvas.LineToF((13 * Size) + X, (8 * Size) + Y);
  Canvas.LineToF((20 * Size) + X, (8 * Size) + Y);
  Canvas.LineToF((14 * Size) + X, (12 * Size) + Y);
  Canvas.LineToF((16 * Size) + X, (20 * Size) + Y);
  Canvas.LineToF((10 * Size) + X, (16 * Size) + Y);
  Canvas.LineToF((4 * Size) + X, (20 * Size) + Y);
  Canvas.LineToF((6 * Size) + X, (12 * Size) + Y);
  Canvas.LineToF((0 * Size) + X, (8 * Size) + Y);
  Canvas.LineToF((6 * Size) + X, (8 * Size) + Y);
  Canvas.ClosePath;
  // Colour it in
  Canvas.Fill;
  Canvas.Stroke;
  // Set 0, 0 point to the centre of the star
  Canvas.Translate((10 * Size) + X, (10 * Size) + Y);
  // Set it back to 0 rotation
  Canvas.Rotate(-(Angle * PI / 180));
  // Restore the 0, 0 point back to 0, 0
  Canvas.Translate(-((10 * Size) + X), -((10 * Size) + Y));
end;

end.