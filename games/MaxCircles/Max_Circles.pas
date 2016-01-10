unit Max_Circles;
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
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  end;

implementation

var
  Colour1, Colour2, Colour3, F1, F2, F3, CircleCount, W, HW, TestR : Integer;
  PastX, PastY, PastR : Array [1..100000] of Integer;
  CurX, CurY, CurR : Integer;
  MaxX, MaxY, MaxR : Integer;
  Count, Count2 : Integer;

procedure TApplication.ApplicationStarting;
begin
  inherited;
  Randomize;
  GameView.Delay := 10;
  GameView.StartSession(True);                                                  //The width is set and the
  W := 300;                                                                     //half-width is calculated
  HW := W DIV 2;                                                                //as they are both used repeatedly
  GameView.Width := W;
  GameView.Height := W;
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
var
  Count, Count2, Count3 : Integer;
begin
  if CircleCount = 0 then
    begin                            //The screen is drawn a specific
      Canvas.FillStyle := 'Black';   //colour when the program starts.
      Canvas.FillRect(0, 0, W, W);
    end;

  Colour1 := RandomInt(175);
  Colour2 := RandomInt(100) + 156;   //The colours are biased to be
  Colour3 := RandomInt(100) + 100;   //certain hues.

  CurX := RandomInt(W + 1);            //The first circle is plotted
  CurY := RandomInt(W + 1);            //randomly.

  CurR := HW - ABS(HW - CurX);
  if CurR > (HW - ABS(HW - CurY)) then   //This makes the radius such that
    CurR := HW - ABS(HW - CurY);         //it touches the closest edge.

  MaxR := 0;

  if CircleCount <> 0 then
    begin
      for Count := 1 to W do
        begin
          CurX := Count;
          for Count2 := 1 to W do
            begin                       //This scans through each pixel
              CurY := Count2;           //and determines the maximum size
                                        //of a circle plotted at that point
              CurR := HW - ABS(HW - CurX);
              if CurR > (HW - ABS(HW - CurY)) then
                CurR := HW-ABS(HW - CurY);
                                                  //Here it finds the radius that makes
              for Count3 := 1 to CircleCount do  //it touch the edge of another circle.
                begin
                  if CurR > (Sqrt(Sqr(CurX - PastX[Count3]) + Sqr(CurY - PastY[Count3])) - PastR[Count3]) then
                    CurR := Round(Sqrt(Sqr(CurX - PastX[Count3]) + Sqr(CurY - PastY[Count3])) - PastR[Count3]);
                  if CurR <= 0 then
                    Break;                   //If the pixel is inside a circle it is
                end;                         //discounted

              if CurR > MaxR then
                begin                //It checks if it is the largest possible
                  MaxX := CurX;      //circle drawable. If it is it saves the point
                  MaxY := CurY;
                  MaxR := CurR;
                end;
            end;
        end;
      CurX := MaxX;             //The centre and radius of the largest
      CurY := MaxY;             //circle is loaded for use.
      CurR := MaxR;
    end;

  if CurR <> 0 then              //Checks that the circle has size.
    begin
      Canvas.FillStyle := 'rgb('+IntToStr(Colour1)+ ',' + IntToStr(Colour2) + ','
                                + IntToStr(Colour3) + ')';
      Canvas.BeginPath; //Draw the circle.
      Canvas.Ellipse(CurX - CurR, CurY - CurR, CurX + CurR, CurY + CurR);
      Canvas.ClosePath;
      Canvas.Fill;

      Inc(CircleCount);            //The location and size is saved
      PastX[CircleCount] := CurX;  //so the circles will not overlap.
      PastY[CircleCount] := CurY;
      PastR[CircleCount] := CurR;
    end;
end;

end.
