unit BlendingEllipse;
{
    Copyright (c) 2014 Alex Karet

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

var
  first: boolean = true;

implementation

procedure TApplication.ApplicationStarting;
begin
  inherited;
  GameView.Delay := 1;
  Gameview.AlphaBlend := True;
  GameView.StartSession(True);
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
var
  Draw: array [1..4] of integer;
  color: integer;
begin
  // Clear background
  if first then begin
     Canvas.FillStyle := 'black';
     Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
     first := False;
  end;
  randomize;

  draw[1] := RandomInt(GameView.Width);
  draw[2] := RandomInt(GameView.Height);
  draw[3] := draw[1] + RandomInt(100);
  draw[4] := draw[2] + RandomInt(100);
  color := round((random * 10) / 2);
  Canvas.FillStyle := 'rgba(' + inttostr(randomint(255)) + ',' + inttostr(randomint(255)) +
                            ',' + inttostr(randomint(255)) + ',' + floattostr(random / 2) + ')';
  Canvas.BeginPath;
  Canvas.Ellipse(draw[1], draw[2], draw[3], draw[4]);
  Canvas.ClosePath;
  Canvas.Fill;
end;

end.
