unit uMain;
{
    Copyright (c) 2013 Nikhil

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted to Smart Pascal by PPS 2015
}
interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics, SmartCL.Controls.Button, SmartCL.Touch,
  uCrtCanvas;

type
  TCanvasProject = class(TW3CustomGameApplication)
  private
    const DELAY = 1;
    const SCALE_FACTOR = 1;
    const CELL_WIDTH = 5 * SCALE_FACTOR;
    const CELL_HEIGHT = 8 * SCALE_FACTOR;
    const FONT_SIZE = 9 * SCALE_FACTOR;
    const ROWS = 25;
    const COLS = 80;
    const WIDTH = COLS * CELL_WIDTH;
    const HEIGHT = ROWS * CELL_HEIGHT;
    btnLeft, btnRight, btnUp, btnDown: TW3Button;
    Grid: TConsoleGrid;
    FrameNumber, PlayerX, PlayerY: integer;
    Maze: array[1..24] of string = [
    '################################################################################',
    '#                     #                                                         ',
    '#   ###############   ###############   #############   ########################',
    '#   #   ##  ##    #   ###############   #   #########   #                     ##',
    '#   #             #   ###############   #   #########   #   ###############   ##',
    '#   #   ###########   ###############   #   #########   #   ###############   ##',
    '#                                       #                   #######       #   ##',
    '#   #########################   #########   #########################   ###   ##',
    '#   #                       #   #########   #########################         ##',
    '#   #   #################   #   #       #   ####################################',
    '#   #                   #   #   #   #   #   #                       ############',
    '#   #################   #   #   #   #   #   #   #################   ############',
    '#                       #   #       #   #   #   #######      #  #   ###       ##',
    '###############   ###########   #########   #   ###  ##   #  #  #   ###   #   ##',
    '###############   ###########   #########   #   ###  ##   #  #  #   ###   #   ##',
    '#             #   ####   ####       #####   #   ###  ##   #  #  #   ###   #   ##',
    '#   #######   #   ##       ##   #   #####   #   ###  ##   #  #  #         #   ##',
    '#   #     #   #   ##   #   ##   #     ###   #   ###  ##   #  #  #   ###   #   ##',
    '#   #   ###   ######   #   ##   #########   #   ###  ##   #  #  #   ###   #   ##',
    '#   #             ##   #   ##   #########   #   ###  ##   #  #  #   ###   #   ##',
    '#   ################   #   ##   #                     #   #     ###########   ##',
    '#   ################   #   ############################   #################   ##',
    '#                      #                                                      ##',
    '################################################################################'];

    start, finish: TDateTime;
    seconds: real;
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure KeyDownEvent(mCode: integer);
    procedure GoToXY(X, Y: integer);
    function Random(LessThan : integer) : integer;
    procedure SetupGameButton(Btn: TW3Button; Capt: string;
                              W, L, T: integer; var Pressed: Boolean);
  end;

implementation

var
  PressedLeft, PressedRight, PressedUp, PressedDown: Boolean;


function TCanvasProject.Random(LessThan: integer): integer;
begin
  Result := RandomInt(LessThan);
end;

procedure TCanvasProject.KeyDownEvent(mCode: integer);
begin
  GoToXY(PlayerX, PlayerY);
  case mCode of
    37, 65: if Grid.getCharacters[Grid.CursorX - 1, Grid.CursorY].Letter <> '#' then
              Grid.CursorX := Grid.CursorX - 1;  //move left if not blocked
    39, 68: if Grid.getCharacters[Grid.CursorX + 1, Grid.CursorY].Letter <> '#' then
              Grid.CursorX := Grid.CursorX + 1;  //move right if not blocked
    38, 87: if Grid.getCharacters[Grid.CursorX, Grid.CursorY - 1].Letter <> '#' then
              Grid.CursorY := Grid.CursorY - 1;  //move up if not blocked
    40, 83: if Grid.getCharacters[Grid.CursorX, Grid.CursorY + 1].Letter <> '#' then
              Grid.CursorY := Grid.CursorY + 1;  //move down if not blocked
    27: GameView.EndSession;
  end;
  PlayerX := Grid.CursorX;
  PlayerY := Grid.CursorY;
end;

procedure TCanvasProject.GoToXY(X, Y: integer);
begin
  Grid.CursorX := X;
  Grid.CursorY := Y;
end;

procedure TCanvasProject.SetupGameButton(Btn: TW3Button; Capt: string;
                                         W, L, T: integer; var Pressed: Boolean);
begin
  Pressed := False;
  Btn.Caption := Capt;
  Btn.Width := W;
  Btn.Left := L;
  Btn.Top := T;
  Btn.OnMouseDown := lambda Pressed := True; end;
  btn.OnMouseUp := lambda Pressed := False; end;
  btn.OnTouchBegin := lambda Pressed := True; end;
  btn.OnTouchEnd := lambda Pressed := False; end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  Randomize;
  Grid := new TConsoleGrid;
  Grid.Rows := ROWS;
  Grid.Cols := COLS;

  btnLeft := TW3Button.Create(Document);
  SetupGameButton(btnLeft, '←', 60, 5, HEIGHT + 5, PressedLeft);
  btnRight := TW3Button.Create(Document);
  SetupGameButton(btnRight, '→', 60, 85, HEIGHT + 5, PressedRight);
  btnUp := TW3Button.Create(Document);
  SetupGameButton(btnUp, '↑', 60, 165, HEIGHT + 5, PressedUp);
  btnDown := TW3Button.Create(Document);
  SetupGameButton(btnDown, '↓', 60, 245, HEIGHT + 5, PressedDown);

  asm
    window.onkeydown = function(e)
    {
    TCanvasProject.KeyDownEvent(Self,e.keyCode);
    }
    window.focus();
  end;
  KeyDownEvent(0);
  GameView.Delay := DELAY;
  GameView.StartSession(False);
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  Grid.Destroy;
  inherited;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);

  procedure TextColor(colour: TConsoleColour);
  begin
    Grid.TextColour := colour;
  end;

  procedure TextBackground(colour: TConsoleColour);
  begin
    Grid.BackgroundColour := colour;
  end;

  procedure write(txt: string);
  begin
    Grid.write(txt);
  end;

  procedure writeln(txt : string);
  begin
    Grid.write(txt);
    Grid.CursorX := 1;
    Grid.CursorY := Grid.CursorY + 1;
  end;

  procedure ClrScr;
  begin
    Grid.ClearGrid;
  end;

  procedure ClrEOL;
  begin
    grid.ClearEol(Grid.CursorX, Grid.CursorY);
  end;

  procedure PaintGrid;
  begin
    Canvas.Font := IntToStr(FONT_SIZE) + 'px Lucida Console, Monaco, monospace';
    var currentChar: TCharacter;
    for var x := 1 to COLS do
      for var y := 1 to ROWS do
        begin
          currentChar := Grid.getCharacters[x, y];
          SetTextColor(currentChar.TextBackGroundColour, Canvas);
          Canvas.FillRect((x - 1) * CELL_WIDTH, ((y - 1) * CELL_HEIGHT) + 1, CELL_WIDTH, CELL_HEIGHT);
          SetTextColor(currentChar.TextColour, Canvas);
          Canvas.FillText(currentChar.Letter, (x - 1) * CELL_WIDTH, y * CELL_HEIGHT);
        end;
  end;
begin
  inc(FrameNumber);
  textColor(green);
  textBackground(brown);
  clrscr;
  if framenumber = 1 then
    begin
      start := time;
      for var row := 1 to 24 do  //populating grid without player
        writeln(Maze[row]);
      PlayerX := 79;
      PlayerY := 2;
    end
  else
    begin
      GoToXY(1, 1);
      for var row := 1 to 24 do // populating grid without player
        writeln(Maze[row]);
      GoToXY(PlayerX, PlayerY);
      if PressedLeft and (Grid.getCharacters[Grid.CursorX - 1, Grid.CursorY].Letter <> '#') then
        begin
          Grid.CursorX := Grid.CursorX - 1;  //move left if not blocked
          PlayerX := Grid.CursorX;
        end
      else if PressedRight and (Grid.getCharacters[Grid.CursorX + 1, Grid.CursorY].Letter <> '#') then
        begin
          Grid.CursorX := Grid.CursorX + 1;  //move right if not blocked
          PlayerX := Grid.CursorX;
        end
      else if PressedUp and (Grid.getCharacters[Grid.CursorX, Grid.CursorY - 1].Letter <> '#') then
        begin
          Grid.CursorY := Grid.CursorY - 1;  //move up if not blocked
          PlayerY := Grid.CursorY;
        end
      else if PressedDown and (Grid.getCharacters[Grid.CursorX, Grid.CursorY + 1].Letter <> '#') then
        begin
          Grid.CursorY := Grid.CursorY + 1;  //move down if not blocked
          PlayerY := Grid.CursorY;
        end;
      // teleporting
      if (PlayerX = 27) and (PlayerY = 13) then
        begin
          PlayerX -= 11;
          PlayerY +=7;
        end;
      if (PlayerX = 18) and (PlayerY = 20) then
        begin
          PlayerX += 10;
          PlayerY -= 7;
        end;
      if (PlayerX = 10) and (PlayerY = 18) then
        begin
          finish := time;
          seconds := (finish - start) * 24 * 60 * 60;
          var secs := round(seconds);
          ShowMessage('You win in ' + inttostr(secs) + ' seconds! Refresh for another try.');
          GameView.EndSession;
        end;
    end;
  // Target and teleporting symbols
  goToXY(10, 18);
  textcolor(white);
  write('0');
  textcolor(blue);
  goToXY(27, 13);
  write('X');
  goToXY(18, 20);
  write('X');

  goToXY(PlayerX, PlayerY);
  textcolor(yellow);
  write('@');
  PaintGrid;
end;

end.
