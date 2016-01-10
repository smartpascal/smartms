unit cubedmaze;
{
    Copyright (c) 2015 Matthew

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics, System.Colors;

type
  TDirection = (Up, Down, Left, Right);

  TCanvasProject = class(TW3CustomGameApplication)
  private
    direction: tdirection;
    moveattempt:boolean;
    PlayerX, PlayerY, Moves, finishface, finishfacex, finishfacey, finishfacexchanged,
      finishfaceychanged: integer;

    MoveDist = 2;
    facenumber = 1;
    const PLAYER_SIZE = 5;
    Score = -1;
  protected
    procedure KeyDownEvent(mCode: integer);
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure finishfacemove;
  end;

implementation

procedure TCanvasProject.KeyDownEvent(mCode: integer);
begin
  MoveAttempt := True;
  case mCode of
    27: Application.Terminate;
    37, 65: Direction := Left;
    38, 87: Direction := Up;
    39, 68: Direction := Right;
    40, 83: Direction := Down;
    0: MoveAttempt := False;
  end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  asm
    window.onkeydown=function(e)
    {
      TCanvasProject.KeyDownEvent(Self,e.keyCode);
    }
    window.focus();
  end;
  KeyDownEvent(0);

  GameView.Width := 300;
  GameView.Height := 151;
  GameView.Delay := 20;
  PlayerX := 7;
  Playery := 7;
  Moves := 0;
  randomize;
  finishfacemove;
  GameView.StartSession(True);
end;

procedure TCanvasProject.finishfacemove;
begin
  finishface := randomint (6) + 1;
  finishfacex := randomint (6) + 1 ;
  finishfacey := randomint (6) + 1;
  Score += 1;
  case finishfacex of
    1: finishfacexchanged := 12;
    2: finishfacexchanged := 37;
    3: finishfacexchanged := 62;
    4: finishfacexchanged := 87;
    5: finishfacexchanged := 112;
    6: finishfacexchanged := 137;
  end;

  case finishfacey of
    1: finishfaceychanged := 12;
    2: finishfaceychanged := 37;
    3: finishfaceychanged := 62;
    4: finishfaceychanged := 87;
    5: finishfaceychanged := 112;
    6: finishfaceychanged := 137;
  end;
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);

  procedure face1;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(100, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 150);
    canvas.MoveToF(125, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(1, 150);
    canvas.LineToF(100, 150);
    canvas.MoveToF(125, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 100);
    canvas.MoveToF(1, 125);
    canvas.LineToF(1, 150);
    canvas.MoveToF(1, 25);
    canvas.LineToF(100, 25);
    canvas.MoveToF(125, 23);
    canvas.LineToF(125, 50);
    canvas.MoveToF(127, 50);
    canvas.LineToF(25, 50);
    canvas.MoveToF(25, 48);
    canvas.LineToF(25, 150);
    canvas.MoveToF(150, 75);
    canvas.LineToF(50, 75);
    canvas.MoveToF(25, 100);
    canvas.LineToF(125, 100);
    canvas.MoveToF(50, 125);
    canvas.LineToF(150, 125);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 255, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 1);
    canvas.LineToF(125, 1);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 252, 0)';
    canvas.BeginPath;
    canvas.MoveToF(1,100);
    canvas.LineToF(1,125);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 248, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100,150);
    canvas.LineToF(125,150);
    canvas.Stroke;

    canvas.ClosePath;
    if finishface = 1 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

  procedure face2;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(100, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 150);
    canvas.MoveToF(125, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(1, 150);
    canvas.LineToF(100, 150);
    canvas.MoveToF(125, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 150);
    canvas.MoveToF(25, 125);
    canvas.LineToF(125, 125);
    canvas.MoveToF(1, 100);
    canvas.LineToF(50, 100);
    canvas.MoveToF(150, 100);
    canvas.LineToF(100, 100);
    canvas.MoveToF(25, 75);
    canvas.LineToF(125, 75);
    canvas.MoveToF(1, 50);
    canvas.LineToF(50, 50);
    canvas.MoveToF(150, 50);
    canvas.LineToF(100, 50);
    canvas.MoveToF(25, 25);
    canvas.LineToF(125, 25);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 254, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 150);
    canvas.LineToF(125, 150);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 255, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 1);
    canvas.LineToF(125, 1);
    canvas.Stroke;
    canvas.ClosePath;

    if finishface = 2 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

  procedure face3;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(100, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 150);
    canvas.MoveToF(125, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(1, 150);
    canvas.LineToF(100, 150);
    canvas.MoveToF(125, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 150);
    canvas.MoveToF(128, 1);
    canvas.LineToF(128, 25);
    canvas.MoveToF(128, 22);
    canvas.LineToF(150, 22);
    canvas.MoveToF(150, 50);
    canvas.LineToF(100, 50);
    canvas.MoveToF(100, 53);
    canvas.LineToF(100, 25);
    canvas.MoveToF(103, 25);
    canvas.LineToF(25, 25);
    canvas.MoveToF(125, 100);
    canvas.LineToF(75, 100);
    canvas.MoveToF(75, 103);
    canvas.LineToF(75, 75);
    canvas.MoveToF(78, 75);
    canvas.LineToF(1, 75);
    canvas.MoveToF(150, 125);
    canvas.LineToF(25, 125);
    canvas.MoveToF(25, 128);
    canvas.LineToF(25, 100);
    canvas.MoveToF(22, 100);
    canvas.LineToF(50, 100);
    canvas.MoveToF(50, 97);
    canvas.LineToF(50, 125);
    canvas.MoveToF(1, 50);
    canvas.LineToF(75, 50);
    canvas.MoveToF(75, 47);
    canvas.LineToF(75, 75);
    canvas.MoveToF(125, 75);
    canvas.LineToF(75, 75);
    canvas.MoveToF(125, 72);
    canvas.LineToF(125, 103);
    canvas.Stroke;
    canvas.StrokeStyle := 'rgb(0, 254, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100,150);
    canvas.LineToF(125,150);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 255, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 1);
    canvas.LineToF(125, 1);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 249, 0)';
    canvas.BeginPath;
    canvas.MoveToF(150, 25);
    canvas.LineToF(150, 50);
    canvas.Stroke;

    canvas.ClosePath;
    if finishface = 3 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

  procedure face4;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(100, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 150);
    canvas.MoveToF(125, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(1, 150);
    canvas.LineToF(100, 150);
    canvas.MoveToF(125, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 150);
    canvas.MoveToF(25, 125);
    canvas.LineToF(150, 125);
    canvas.MoveToF(27, 125);
    canvas.LineToF(25, 25);
    canvas.MoveToF(50, 1);
    canvas.LineToF(50, 100);
    canvas.MoveToF(75, 125);
    canvas.LineToF(75, 25);
    canvas.MoveToF(100, 1);
    canvas.LineToF(100, 100);
    canvas.MoveToF(97, 100);
    canvas.LineToF(125, 100);
    canvas.MoveToF(125, 25);
    canvas.LineToF(125, 75);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 254, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 150);
    canvas.LineToF(125, 150);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 253, 0)';
    canvas.BeginPath;
    canvas.MoveToF(100, 1);
    canvas.LineToF(125, 1);
    canvas.Stroke;

    canvas.ClosePath;
    if finishface = 4 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

  procedure face5;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 100);
    canvas.MoveToF(1, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 150);
    canvas.MoveToF(150, 125);
    canvas.LineToF(150, 150);
    canvas.MoveToF(150, 97);
    canvas.LineToF(125, 97);
    canvas.MoveToF(125, 95);
    canvas.LineToF(125, 125);
    canvas.MoveToF(25, 1);
    canvas.LineToF(25, 125);
    canvas.MoveToF(50, 25);
    canvas.LineToF(50, 150);
    canvas.MoveToF(75, 1);
    canvas.LineToF(75, 125);
    canvas.MoveToF(100, 25);
    canvas.LineToF(100, 150);
    canvas.MoveToF(97, 25);
    canvas.LineToF(125, 25);
    canvas.MoveToF(125, 22);
    canvas.LineToF(125, 75);
    canvas.MoveToF(100, 75);
    canvas.LineToF(128, 75);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 251, 0)';
    canvas.BeginPath;
    canvas.MoveToF(150, 100);
    canvas.LineToF(150, 125);
    canvas.Stroke;

    canvas.ClosePath;
    if finishface = 5 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

  procedure face6;
  begin
    canvas.MoveToF(0, 1);
    canvas.LineToF(150, 1);
    canvas.MoveToF(150, 0);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 150);
    canvas.LineToF(150, 150);
    canvas.MoveToF(1, 1);
    canvas.LineToF(1, 150);
    canvas.MoveToF(25, 1);
    canvas.LineToF(25, 125);
    canvas.MoveToF(50, 25);
    canvas.LineToF(50, 150);
    canvas.MoveToF(75, 1);
    canvas.LineToF(75, 125);
    canvas.MoveToF(100, 25);
    canvas.LineToF(100, 150);
    canvas.MoveToF(125, 1);
    canvas.LineToF(125, 125);
    canvas.Stroke;

    canvas.StrokeStyle := 'rgb(0, 250, 0)';
    canvas.BeginPath;
    canvas.MoveToF(1, 25);
    canvas.LineToF(1, 50);
    canvas.Stroke;

    canvas.ClosePath;
    if finishface = 6 then
      begin
        Canvas.FillStyle := 'rgb(0, 0, 255)';
        Canvas.FillRectF(finishfacexchanged, finishfaceychanged, 5, 5);
      end;
  end;

begin
  Canvas.FillStyle := 'rgb(0, 0, 50)';
  Canvas.FillRectF(0, 0, 300, 151);
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'rgb(255, 255, 255)';
  canvas.StrokeStyle := 'rgb(255, 0, 0)';
  canvas.LineWidth := 5;
  Canvas.FillTextF('Score: ' + IntToStr(Score), 160, 10, MAX_INT);
  Canvas.FillTextF('See pp4s.co.uk for' , 160, 30, MAX_INT);
  Canvas.FillTextF('credits' , 160, 40, MAX_INT);
  canvas.BeginPath;

  case facenumber of
    1: face1;
    2: face2;
    3: face3;
    4: face4;
    5: face5;
    6: face6;
  end;

  if MoveAttempt = True then
    begin
      inc(Moves);
      case Direction of
        Up: begin
              var PixelData1 := Canvas.GetImageData(PlayerX, PlayerY - MoveDist, 1, 1).GetPixel(0, 0);
              var PixelData2 := Canvas.GetImageData(PlayerX + PLAYER_SIZE - 1, PlayerY - MoveDist, 1, 1).GetPixel(0, 0);
              if (PixelData1.R <> 255) and (PixelData2.R <> 255) then
                 PlayerY -= MoveDist;
              if (PixelData1.G = 255) or (PixelData2.G = 255) then
                begin
                  facenumber += 1;
                  Playerx := 112;
                  Playery := 138;
                end;

              if (PixelData1.G = 253) or (PixelData2.G = 253) then
                begin
                  facenumber := 1;
                  Playerx := 112;
                  Playery := 138;
                end;

              if (PixelData1.B = 255) or (PixelData2.B = 255) then
                finishfacemove;

            end;
        Left: begin
                var PixelData1 := Canvas.GetImageData(PlayerX - MoveDist, PlayerY, 1, 1).GetPixel(0, 0);
                var PixelData2 := Canvas.GetImageData(PlayerX - MoveDist, PlayerY + PLAYER_SIZE - 1, 1, 1).GetPixel(0, 0);
                if (PixelData1.R <> 255) and (PixelData2.R <> 255) then
                  PlayerX -= MoveDist;

                if (PixelData1.G = 252) or (PixelData2.G = 252) then
                  begin
                    facenumber := 5;
                    Playerx := 138;
                    Playery := 112;
                  end;

                if (PixelData1.G = 250) or (PixelData2.G = 250) then
                  begin
                    facenumber := 3;
                    Playerx := 112;
                    Playery := 30;
                  end;

                if (PixelData1.B = 255) or (PixelData2.B = 255) then
                  finishfacemove;
              end;

        Right: begin
                 var PixelData1 := Canvas.GetImageData(PlayerX + MoveDist + PLAYER_SIZE, PlayerY, 1, 1).GetPixel(0, 0);
                 var PixelData2 := Canvas.GetImageData(PlayerX + MoveDist + PLAYER_SIZE - 1, PlayerY + PLAYER_SIZE - 1, 1, 1).GetPixel(0, 0);
                 if (PixelData1.R <> 255) and (PixelData2.R <> 255) then
                   PlayerX += MoveDist;

                 if (PixelData1.G = 251) or (PixelData2.G = 251) then
                   begin
                     facenumber := 1;
                     Playerx := 12;
                     Playery := 112;
                   end;

                 if (PixelData1.G = 249) or (PixelData2.G = 249) then
                   begin
                     facenumber := 6;
                     Playerx := 12;
                     Playery := 30;
                   end;

                 if (PixelData1.B = 255) or (PixelData2.B = 255) then
                   finishfacemove;
               end;
        Down: begin
                var PixelData1 := Canvas.GetImageData(PlayerX, PlayerY + MoveDist + PLAYER_SIZE, 1, 1).GetPixel(0, 0);
                var PixelData2 := Canvas.GetImageData(PlayerX + PLAYER_SIZE - 1, PlayerY + MoveDist + PLAYER_SIZE, 1, 1).GetPixel(0, 0);
                if (PixelData1.R <> 255) and (PixelData2.R <> 255) then
                  PlayerY += MoveDist;
                if (PixelData1.G = 254) or (PixelData2.G = 254) then
                  begin
                    facenumber -= 1;
                    Playerx := 112;
                    Playery := 7;
                  end;

                if (PixelData1.G = 248) or (PixelData2.G = 248) then
                  begin
                    facenumber := 4;
                    Playerx := 112;
                    Playery := 7;
                  end;

                if (PixelData1.B = 255) or (PixelData2.B = 255) then
                  finishfacemove;
              end;

      end; //end of case
    end; //end of if MoveAttempt
  Canvas.FillStyle := 'Orange';
  Canvas.FillRectF(PlayerX, PlayerY, PLAYER_SIZE, PLAYER_SIZE);
  MoveAttempt := False;
end;

end.
