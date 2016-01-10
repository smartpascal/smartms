unit UScalingInfo;

interface

uses 
  W3Graphics;

procedure ScaleCanvas(newScreenWidth, newScreenHeight : integer);

const
  GAMEWIDTH = 1366;
  GAMEHEIGHT = 598;
  PIXELTOPOWERRATIO = 12;

var
  Scale : float;

implementation

procedure ScaleCanvas(newScreenWidth, newScreenHeight : integer);
var
  gameLength, gameDepth : float;
begin
  // Get the new x and y lengths
  gameLength := newScreenWidth;
  gameDepth := (gameLength / 16) * 7; // Using 16:7 aspect ratio

  // If the new game size is too tall use the height as the base of the new scale
  if gameDepth >= newScreenHeight then
    begin
      gameDepth := newScreenHeight;
      gameLength := (gameDepth / 7) * 16;
    end;

  // Get the new scale
  Scale := gameLength / GAMEWIDTH;
end;


end.
