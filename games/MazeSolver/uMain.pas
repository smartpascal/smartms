unit uMain;

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics, SmartCL.Controls.Button, SmartCL.Touch,
  UMakeMaze;

type
TApplication=class(TW3CustomGameApplication)
private
  { Private methods }
  FMaze : TMaze;
  FMazeOffset : TPoint;
  FMazeCellWidth : Integer;
  FSolvePos : array [0..1] of TPoint;
  FSolveIndex : Integer;
  FGenTimeMSec : Float;
protected
  { protected methods }
  procedure  ApplicationStarting;override;
  procedure  ApplicationClosing;override;
  Procedure  PaintView(Canvas:TW3Canvas);override;
  procedure  ShowMaze ( c : TW3Canvas; maze : TMaze; rows, cols, w, stepWidth, endsWidth, ox, oy : integer );
  procedure  DoMouseDown(Sender:TObject;Button:TMouseButton; Shift: TShiftState; X,Y:Integer);
end;

Implementation

const mazeSize = 64;

//############################################################################
// TApplication
//############################################################################

procedure TApplication.DoMouseDown(Sender:TObject;Button:TMouseButton; Shift: TShiftState; X,Y:Integer);
var
   maze : TMaze;
   solLength, visited : Integer;
begin
   x:=(x-FMazeOffset.X) div FMazeCellWidth;
   y:=(y-FMazeOffset.Y) div FMazeCellWidth;

   FSolvePos[FSolveIndex].X:=ClampInt(x, 0, mazeSize-1);
   FSolvePos[FSolveIndex].Y:=ClampInt(y, 0, mazeSize-1);
   FSolveIndex:=1-FSolveIndex;

   maze:=FMaze;
   InvalidateMazeSolution(maze, mazeSize, mazeSize);
   SolveMaze(maze, mazeSize, mazeSize,
             FSolvePos[0].Y, FSolvePos[0].X,
             FSolvePos[1].Y, FSolvePos[1].X,
             solLength, visited);
   FMaze:=maze;
end;

procedure TApplication.ApplicationStarting;
var
   maze : TMaze;
Begin
  inherited;

  //Initialize refresh interval, set this to 1 for optimal speed
  GameView.Delay:=20;

  FGenTimeMSec:=Now;
  MakeMaze(maze, mazeSize, mazeSize);
  FGenTimeMSec:=(Now-FGenTimeMSec)*86400*1000;

  FMaze:=maze;

  GameView.OnMouseDown:= DoMouseDown;

  //Start the redraw-cycle with framecounter active
  //Note: the framecounter impacts rendering speed. Disable
  //the framerate for maximum speed (false)
  GameView.StartSession(true);
End;

procedure TApplication.ApplicationClosing;
Begin
  GameView.EndSession;
  inherited;
End;

// Note: In a real live game you would try to cache as much
// info as you can. Typical tricks are:
//   1: Only get the width/height when resized
//   2: Pre-calculate strings, especially RGB/RGBA values
//   3: Only redraw what has changed, avoid a full repaint
// The code below is just to get you started

procedure TApplication.PaintView(Canvas:TW3Canvas);
var
   s, w : Integer;
   txt : String;
Begin
  // Clear background
  canvas.fillstyle:='rgb(0,0,99)';
  canvas.fillrectF(0,0,gameview.width,gameview.height);


  s:=Min(gameview.width, gameView.Height);
  w:=s div (mazeSize+mazeSize shr 1);
  FMazeCellWidth:=w;
  FMazeOffset.X:=(gameview.width-w*mazeSize) div 2;
  FMazeOffset.Y:=(gameview.Height-w*mazeSize) div 2;
  ShowMaze(canvas, FMaze, mazeSize, mazeSize,
           w, w div 2, 1, FMazeOffset.X, FMazeOffset.Y);

  // Draw our framerate on the screen
  txt:=Format('Gen: %d ms   FPS: %d', [Round(FGenTimeMSec), GameView.FrameRate]);

  canvas.font:='20pt verdana';
  canvas.FillStyle:='white';
  canvas.FillTextF(txt,12,22,MAX_INT);
  canvas.FillStyle:='blue';
  canvas.FillTextF(txt,10,20,MAX_INT);
End;

procedure TApplication.ShowMaze (c : TW3Canvas; maze : TMaze; rows, cols, w, stepWidth, endsWidth, ox, oy : integer );
var
    i,j                    : integer;
    stepOffset : integer;

begin
    stepOffset := (w-stepWidth+1) div 2;
   // normal color
   c.FillStyle:='white';
   c.StrokeStyle:='black';
   c.FillRectF(ox, oy, (cols)*w, (rows)*w);
   c.LineWidth:=1;

  // backgrounds for solution and start/end cells
  for i := 0 to cols-1 do
      for j := 0 to rows-1 do
      begin
          // if this is a solution cell
          if (maze[j,i] and CELL_VISITED = CELL_VISITED) then
          begin
              c.FillStyle:='#E0E0E0';
              c.FillRectF(ox + i*w + stepOffset,  oy + j*w + stepOffset,
                          stepWidth, stepWidth);
          end;
          if maze[j,i] and CELL_SOLUTION = CELL_SOLUTION then
          begin
              c.FillStyle:='#8080FF';
              c.FillRectF(ox + i*w + stepOffset,  oy + j*w + stepOffset,
                          stepWidth, stepWidth);
          end;

          // paint Start and End Cell
          if (j = FSolvePos[0].Y) and (i = FSolvePos[0].X) then
          begin
              c.FillStyle:='#FF8000';
              c.FillRectF(ox + i*w ,  oy + j*w ,
                          w, w);
          end;
          if (j = FSolvePos[1].Y) and (i = FSolvePos[1].X) then
          begin
              c.FillStyle:='#8080FF';
              c.FillRectF(ox + i*w ,  oy + j*w ,
                          w, w);
          end;
      end;

  // lines
  c.BeginPath;
  for i := 0 to cols-1 do
      for j := 0 to rows-1 do
      begin
          if maze[j,i] and EXIT_EAST = $00 then  // if there is NO exit EAST
          begin
              c.LineF (ox + (i+1)*w, oy + j*w,
                       ox + (i+1)*w, oy + (j+1)*w + 1);
          end;
          if maze[j,i] and EXIT_NORTH = $00 then  // if there is NO exit NORTH
          begin
              c.LineF (ox + i*w,         oy + j*w,
                       ox + (i+1)*w + 1, oy + j*w);
          end;
          if maze[j,i] and EXIT_WEST = $00 then  // if there is NO exit WEST
          begin
              c.LineF (ox + i*w, oy + j*w,
                       ox + i*w, oy + (j+1)*w + 1);
          end;
          if maze[j,i] and EXIT_SOUTH = $00 then  // if there is NO exit SOUTH
          begin
              c.LineF (ox + i*w,         oy + (j+1)*w,
                       ox + (i+1)*w + 1, oy + (j+1)*w);
          end;
      end;
  c.Stroke;
end;

end.
