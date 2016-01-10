unit MovingBallParticles;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  SmartCL.System, SmartCL.Components, SmartCL.Application, SmartCL.Game,
  SmartCL.GameApp, SmartCL.Graphics, UBall;

type
  TApplication = class(TW3CustomGameApplication)
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  end;

var
  Ball : TBall;

implementation

procedure TApplication.ApplicationStarting;
begin
  inherited;
  // Initialize refresh interval
  GameView.Delay := 20;
  GameView.StartSession(False);
  // Create our ball
  Ball := TBall.Create(10, 10, 20, 20, randomInt(20), randomInt(20));
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  // Clear background
  Canvas.FillStyle := 'white';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
  {Draw our framerate on the screen
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'rgb(0, 0, 0)';
  Canvas.FillText('FPS:' + IntToStr(GameView.FrameRate), 10, 20);}
  // Update our ball
  Ball.Update(GameView.Width, GameView.Height);
  // Draw our ball
  Ball.Draw(Canvas);
end;

end.