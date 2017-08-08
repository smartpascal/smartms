unit uCrtCanvas;

interface

uses
  SmartCL.System, System.Colors, SmartCL.Graphics;

type
  TConsoleColour = (black, blue, green, cyan, red, magenta, brown, lightgray,
                    darkgray, lightblue, lightgreen, lightcyan, lightred, lightmagenta, yellow, white);

  TCharacter = record
    Letter: string = ' ';
    TextColour: TConsoleColour = white;
    TextBackgroundColour = black;
  end;

  TCharacters = array[1..80, 1..25] of TCharacter;

  TConsoleGrid = class
  private
    FTextColour: TConsoleColour = black;
    FBackgroundColour: TConsoleColour = white;
    FCursorX: integer = 1;
    FCursorY: integer = 1;
    FRows: integer = 25;
    FCols: integer = 80;
    FCharacters: TCharacters;
  public
    procedure setCharacters(Char: TCharacters);
    function getCharacters: TCharacters;
    procedure SetCursorX(newX: integer);
    procedure SetCursorY(newY: integer);
    procedure SetXY(newRec: TCharacter; X, Y: integer);
    function GetXY(X, Y: integer): TCharacter;
    procedure write(txt: string);
    procedure ClearEOL(startX, clearY: integer);
    procedure ClearCell(clearX, clearY: integer);
    procedure ClearGrid;
    property TextColour: TConsoleColour read FTextColour write FTextColour;
    property BackgroundColour: TConsoleColour read FBackgroundColour write FBackgroundColour;
    property CursorX: integer read FCursorX write SetCursorX;
    property CursorY: integer read FCursorY write SetCursorY;
    property Cols: integer read FCols write FCols;
    property Rows: integer read FRows write FRows;
  end;

procedure SetTextColor(colour: TConsoleColour; Canvas : TW3Canvas);

implementation

procedure SetTextColor(colour: TConsoleColour; Canvas : TW3Canvas);
begin
  case colour of
    black: Canvas.FillStyle := 'black';
    white: Canvas.FillStyle := 'white';
    brown: Canvas.FillStyle := ColorToWebStr(clBrown);
    red: Canvas.FillStyle := 'red';
    magenta: Canvas.FillStyle := ColorToWebStr(clMagenta);
    yellow: Canvas.FillStyle := 'yellow';
    green: Canvas.FillStyle := 'green';
    cyan: Canvas.FillStyle := ColorToWebStr(clCyan);
    blue: Canvas.FillStyle := 'blue';
    lightgray: Canvas.FillStyle := ColorToWebStr(clLightGray);
    darkgray: Canvas.FillStyle := ColorToWebStr(clDarkGray);
    lightred: Canvas.FillStyle := 'rgb(250, 130, 130)';
    lightmagenta: Canvas.FillStyle := 'rgb(250, 130, 250)';
    lightgreen: Canvas.FillStyle := ColorToWebStr(clLightGreen);
    lightcyan: Canvas.FillStyle := ColorToWebStr(clLightCyan);
    lightblue: Canvas.FillStyle := 'rgb(130, 130, 250)';
  end;
end;

procedure TConsoleGrid.setCharacters(Char: TCharacters);
begin
  FCharacters := Char;
end;
function TConsoleGrid.getCharacters: TCharacters;
begin
  Result := FCharacters;
end;

procedure TConsoleGrid.SetCursorX(newX: integer);
begin
  if (newX > 0) and (newX <= Cols) then
    FCursorX := newX;
end;

procedure TConsoleGrid.SetCursorY(newY: integer);
begin
  if (newY > 0) and (newY <= Rows) then
    FCursorY := newY;
end;

procedure TConsoleGrid.SetXY(newRec: TCharacter; X, Y: integer);
begin
  if (X > 0) and (X <= Cols) and (Y > 0) and (Y <= Rows) then
    FCharacters[X, Y] := newRec;
end;

function TConsoleGrid.GetXY(X, Y: integer): TCharacter;
begin
  Result := getCharacters[X, Y];
end;

procedure TConsoleGrid.write(txt: string);
var
  tempchar: TCharacter;
begin
  for var i := 1 to length(txt) do
    begin
      tempChar.TextColour := TextColour;
      tempChar.TextBackgroundColour := BackgroundColour;
      tempChar.Letter := txt[i];
      SetXY(tempChar, CursorX + i - 1, CursorY);
    end;
end;

procedure TConsoleGrid.ClearCell(clearX, clearY: integer);
var
  tempChar: TCharacter;
begin
  tempChar.TextBackgroundColour := BackGroundColour;
  tempChar.Letter := ' ';
  tempChar.TextColour := black; //Not needed
  SetXY(tempChar, clearX, clearY);
end;

procedure TConsoleGrid.ClearEOL(startX, clearY: integer);
begin
  for var x := startX to Cols do
    ClearCell(x, clearY);
end;

procedure TConsoleGrid.ClearGrid;
begin
  for var y := 1 to Rows do
    ClearEOL(1, y);
end;

end.
