unit Unit1;
{
    Copyright (c) 2010 Peter Hearnshaw

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted to Smart Pascal by PPS 2015
}

interface

uses
  System.Types, System.Colors, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics, SmartCL.Controls.Button;

type
  TConsoleColour = (black, blue, green, cyan, red, magenta, brown, lightgray,
                    darkgray, lightblue, lightgreen, lightcyan, lightred, lightmagenta, yellow, white);
type
  TCanvasProject = class(TW3CustomGameApplication)
  private
    const SCALE_FACTOR = 1; // Or 2 if you prefer
    const FONT_SIZE = 9 * SCALE_FACTOR;
    const CHAR_WIDTH = 5 * SCALE_FACTOR;
    const CHAR_HEIGHT = 8 * SCALE_FACTOR;
    const DELAY = 100 div SCALE_FACTOR;
    SceneWidth, SceneHeight: integer;
    BackgroundColour: TConsoleColour;
    charx: integer = 1;
    chary: integer = 1;
    xInc: integer = 1;
    yInc: integer = 0;
    Xpos, Ypos, foodX, foodY, SnakeLen: integer;
    myArrayX : array [1..90] of integer;
    myArrayY : array [1..90] of integer;
    btnLeft, btnRight, btnUp, btnDown: TW3Button;
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure SetupGameButton(Btn: TW3Button; Capt: string;
                              W, L, T: integer);
    procedure KeyDownEvent(mCode: integer);
    procedure GoToXY(X, Y: integer);
    function Random(LessThan : integer) : integer;
  end;

implementation

procedure TCanvasProject.SetupGameButton(Btn: TW3Button; Capt: string;
                                         W, L, T: integer);
begin
  Btn.Caption := Capt;
  Btn.Width := W;
  Btn.Left := L;
  Btn.Top := T;
end;

function TCanvasProject.Random(LessThan : integer) : integer;
begin
  Result := RandomInt(LessThan);
end;

procedure TCanvasProject.KeyDownEvent(mCode: integer);
begin
  case mCode of
    37, 65: begin
              xInc := -1;
              yInc := 0;
            end;
    39, 68: begin
              xInc := 1;
              yInc := 0;
            end;
    38, 87: begin
              xInc := 0;
              yInc := -1;
            end;
    40, 83: begin
              xInc := 0;
              yInc := 1;
            end;
    27:     GameView.EndSession;

  end;
end;

procedure TCanvasProject.GoToXY(X, Y: integer);
begin
  Xpos := X;
  YPos:= Y;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  SceneWidth := 80 * CHAR_WIDTH;
  SceneHeight := 25 * CHAR_HEIGHT;
  foodX := random(79) + 1; //foodX becomes a random number from 1 to 80
  foodY := random(24) + 1; //foodY becomes a random number from 1 to 25
  SnakeLen := 3; //Start length of the snake
  asm
    window.onkeydown = function(e)
    {
    @TCanvasProject.KeyDownEvent(@Self,e.keyCode);
    }
    window.focus();
  end;
  KeyDownEvent(0);

  btnLeft := TW3Button.Create(Document);
  btnLeft.OnClick := lambda  xInc := -1; yInc := 0; end;
  SetupGameButton(btnLeft, '←', 60, 5, SceneHeight + 5);

  btnRight := TW3Button.Create(Document);
  btnRight.OnClick := lambda  xInc := 1; yInc := 0; end;
  SetupGameButton(btnRight, '→', 60, 85, SceneHeight + 5);

  btnUp := TW3Button.Create(Document);
  SetupGameButton(btnUp, '↑', 60, 165, SceneHeight + 5);
  btnUp.OnClick := lambda  xInc := 0; yInc := -1; end;

  btnDown := TW3Button.Create(Document);
  SetupGameButton(btnDown, '↓', 60, 245, SceneHeight + 5);
  btnDown.OnClick := lambda  xInc := 0; yInc := 1; end;

  GameView.Delay := DELAY;
  GameView.StartSession(False);
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);

  procedure TextColor(colour: TConsoleColour);
  begin
    case colour of
      brown: Canvas.FillStyle := ColorToWebStr(clBrown);
      yellow: Canvas.FillStyle := 'yellow';
      lightgreen: Canvas.FillStyle := ColorToWebStr(clLightGreen);
    end;
  end;

  procedure TextBackground(colour: TConsoleColour);
  begin
    BackgroundColour := colour;
    TextColor(colour);
  end;

  procedure write(txt : string);
  begin
    Canvas.Font := IntToStr(FONT_SIZE) + 'px Lucida Console, Monaco, monospace';
    Canvas.FillText(txt, (XPos -1) * CHAR_WIDTH, YPos * CHAR_HEIGHT);
  end;

  procedure ClrScr;
  begin
    TextBackground(BackgroundColour);
    Canvas.FillRectF(0, 0, SceneWidth, SceneHeight);
  end;

begin
  TextBackground(brown);
  ClrScr;
  charx := charx + xInc; //head of snake increases in X by xInc
  chary := chary + yInc; //head of snake increases in Y by yInc

  //If the snake is off the screen in any of the four sides the snake head will move to the opposite side.
  if chary = 0 then
    chary := 25;
  if chary = 26 then
    chary := 1;
  if charX = 0 then
    charX := 80;
  if charX = 81 then
    charX := 1;

  // array contains all positions the head of the snake has been on previous repeats
  // insert the new snake head value and shuffle all the other other body segment positions
  // along one and the end body segment will disappear

  for var lx := 1 to SnakeLen - 1 do
    begin
      myArrayX[lx] := myArrayX[lx + 1];
      myArrayY[lx] := myArrayY[lx + 1];
    end;
  myArrayX[SnakeLen] := charX;
  myArrayY[SnakeLen] := charY;
  //For all the values in the array add an O as a body segment.
  for var lx := 1 to SnakeLen do
    begin
      gotoXY(myArrayX[lx], myArrayY[lx]);
      textcolor(lightgreen);
      write('O');
    end;
  gotoXY(foodX, foodY);
  textcolor(yellow);
  write('@');
  //if the snake head is on the food position
  if (charX = foodX) and (charY = foodY) then
    begin
      //then move the food positions again
      foodX := random(79) + 1;
      foodY := random(24) + 1;
      //and make the snake longer
      if not (SnakeLen > 89) then
        SnakeLen := SnakeLen + 1;
    end;
end;

end.
