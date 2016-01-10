unit Unit1;
{
    PlatformDemo  Copyright (c) 2014 Steven Binns

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics;

type
  TPlayer = class(TObject)
  public
    radius: integer;
    x, y, xSpeed, ySpeed, grav: real;  //ySpeed is positive moving up.
    moveLeft, moveRight: boolean;
    leftKey, rightKey, jumpKey: integer;
    colour: string;
    constructor Create(newX, newY, newR, newLk, newRk, newJk: integer; newColour: String);
  end;

  TPlatform = class(TObject)
  public
    x, y, width, height: real;
    constructor create(newX, newY, newW, newH: real);
  end;

  TCanvasProject = class(TW3CustomGameApplication)
  private
     players : array[1..2] of TPlayer;
     platforms: array[0..3] of TPlatform;
     collision: boolean;
     gvWidth, gvHeight: integer;
     function checkVCollision(k, subject: integer): boolean;
     function checkHCollision(k, subject: integer): boolean;
  protected
    procedure  ApplicationStarting; override;
    procedure  ApplicationClosing; override;
    procedure  PaintView(Canvas: TW3Canvas); override;
    procedure  KeyDownEvent(mCode: integer);
    procedure  KeyUpEvent(mCode: integer);
end;

implementation

{ TCanvasProject}

{General functions}
function TCanvasProject.checkVCollision(k, subject : integer): boolean;
  function hAlignment: boolean;  //Nested function
  //If player's right extremity to right of left edge of platform k and
  //player's left extremity to left of right edge of platform k then return true.
  begin
    result := false;
    if (players[subject].x + players[subject].radius > platforms[k].x) and
       (players[subject].x - players[subject].radius < platforms[k].x + platforms[k].width) then
      result := true;
  end;
begin
  result := false;
  //If ascending and horizontally aligned and
  //top of player under bottom of platform k and
  // next move would enter platform k then return true.
  if (players[subject].ySpeed > 0) and hAlignment and
     (players[subject].y - players[subject].radius > platforms[k].y + platforms[k].height) and
     (players[subject].y - players[subject].yspeed - players[subject].radius < platforms[k].y + platforms[k].height) then
     result := true;
  //If descending and horizontally aligned and
  // bottom of player under top of platform k and
  // next move would enter platform k then return true.
  if (players[subject].yspeed < 0) and hAlignment and
    (players[subject].y + players[subject].radius < platforms[k].y) and
    (players[subject].y + players[subject].radius - players[subject].ySpeed > platforms[k].y) then
    result := true;

  if (players[subject].yspeed = 0) and hAlignment and
     (players[subject].y + players[subject].radius = platforms[k].y) and
     (players[subject].y + players[subject].radius + 1 > platforms[k].y) then
    result := true;
end;

function TCanvasProject.checkHCollision(k, subject: integer): boolean;
  function vAlignment: boolean;  //Nested function
  begin
    result := false;
    if (players[subject].y - players[subject].radius < platforms[k].y + platforms[k].height) and
       (players[subject].y + players[subject].radius > platforms[k].y) then
      result := true;
  end;
begin
  result := false;
  //If moving right and vertically aligned and
  //player's right extremity to left or same as platform's left edge and
  //next move would enter platform then return true.
  if (players[subject].xspeed > 0) and vAlignment and
     (players[subject].x + players[subject].radius <= platforms[k].x) and
     (players[subject].x + players[subject].radius + players[subject].xSpeed > platforms[k].x) then
    result := true;
  //If moving left and vertically aligned and
  //player's left extremity to right or same as platform's right edge and
  //next move would enter platform then return true.
  if (players[subject].xspeed < 0 ) and vAlignment and
     (players[subject].x - players[subject].radius >= platforms[k].x + platforms[k].width) and
     (players[subject].x - players[subject].radius + players[subject].xspeed < platforms[k].x + platforms[k].width) then
    result := true;
end;
procedure TCanvasProject.KeyDownEvent(mCode: integer);
var
  i : integer;
begin
  for i := 1 to 2 do
    case mCode of
      players[i].leftKey: if players[i].moveRight = false then
                            players[i].moveLeft := true;
      players[i].rightKey: if players[i].moveLeft = false then
                             players[i].moveRight := true;
      players[i].jumpKey: if players[i].ySpeed = 0 then
                            players[i].ySpeed := 5;
    end;
end;

procedure TCanvasProject.KeyUpEvent(mCode: integer);
var
  i : integer;
begin
  for i := 1 to 2 do
    case mCode of
      players[i].leftKey: players[i].moveLeft := false;
      players[i].rightKey: players[i].moveRight := false;
    end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
   players[1] := TPlayer.Create(150, 50, 5, 37, 39, 38, 'red'); //lKey:left rKey:right jKey:up
   players[2] := TPlayer.Create(50, 50, 5, 65, 68, 87, 'blue'); //lKey:a rKey:d jKey:w
  asm
    window.onkeydown = function(e)
    {
    TCanvasProject.KeyDownEvent(Self,e.keyCode);
    }
    window.onkeyup = function(e)
    {
    TCanvasProject.KeyUpEvent(Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  KeyUpEvent(0);

  GameView.Width := 300;
  GameView.Height := 150;
  gvWidth := 300;
  gvHeight := 150;
  platforms[0] := TPlatform.create(50, GameView.Height - 30, 20, 5);
  platforms[1] := TPlatform.create(100, GameView.Height - 35, 15, 2);
  platforms[2] := TPlatform.create(150, GameView.Height - 45, 20, 10);
  platforms[3] := TPlatform.create(200, GameView.Height - 55, 5, 3);
  GameView.Delay := 10;
  GameView.StartSession(True);
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
var
  i, j, k : integer;
begin
  for j := 1 to 2 do  // Step players
    begin // Players will gain speed up to a max value while key pressed.
      if (players[j].moveRight = true) and (players[j].xSpeed < 3) then
        players[j].xSpeed += 0.25;
      if (players[j].moveLeft = true) and (players[j].xSpeed > -3) then
        players[j].xSpeed -= 0.25;
      //Check for horizontal collisions.
      collision := false;
      for k := 0 to 3 do
        begin
          if checkHCollision(k, j) = true then
            begin
              collision := true;
              break; //Collision platform's number = k
            end;
        end;

  if collision = false then  //Continue to move.
    players[j].x += players[j].xSpeed
  else //Horizontal collision
    begin  //Prevent player from entering platform and stop horizontal movement.
      if players[j].xSpeed > 0 then
        begin
          players[j].x := platforms[k].x - players[j].radius;
          players[j].xSpeed := 0;
        end;
      if players[j].xSpeed < 0 then
        begin
          players[j].x := platforms[k].x + platforms[k].width + players[j].radius;
          players[j].xSpeed := 0;
        end;
    end;
  //Keep players horizontally in the GameView.
  if players[j].x + players[j].radius > gvWidth then
    players[j].x := gvWidth - players[j].radius;
  if players[j].x - players[j].radius < 0 then
    players[j].x := players[j].radius;
  //Create horizontal friction by reducing the speed.
  if (players[j].moveLeft = false) and (players[j].moveRight = false) then
    begin
      if players[j].xSpeed < 0 then
        players[j].xSpeed += 0.125
      else if players[j].xSpeed > 0 then
        players[j].xSpeed -= 0.125;
    end;
  //Deal with jumping and gravity
  collision := false;
  for k := 0 to 3 do
    begin
      if checkVCollision(k, j) = true then
        begin
          collision := true;
          break; //k holds platform number of collision
        end;
    end;
  if collision = false then
    begin
      players[j].y -= players[j].ySpeed;
      if players[j].y + players[j].radius < gvHeight then
        begin
          players[j].ySpeed -= players[j].grav;
          players[j].grav += 0.1;
        end
      else
        begin //Player has reached the floor so position it exactly on the floor.
          players[j].y := gvHeight - players[j].radius;
          players[j].ySpeed := 0;
          players[j].grav := 0;
        end;
    end
  else //vertical collision
    begin
      if players[j].ySpeed > 0 then  //Hits bottom of platform k
        begin  //Position it just under platform.
          players[j].y := platforms[k].y + platforms[k].height + players[j].radius;
          players[j].ySpeed := 0;
          players[j].grav := 0;
        end;
      if players[j].yspeed < 0 then  //Hits top of platform k
        begin   //Place it on platform k.
          players[j].y := platforms[k].y - players[j].radius;
          players[j].ySpeed := 0;
          players[j].grav := 0;
        end;
    end;
  end; //Finished stepping players
  // Clear background with colour gray.
  Canvas.FillStyle := 'gray';
  Canvas.FillRect(0, 0, gvWidth, gvHeight);
  //Draw circles for players.
  for i := 1 to 2 do
    begin
      Canvas.FillStyle := players[i].colour;
      Canvas.BeginPath;
      Canvas.Ellipse(players[i].x - players[i].radius, players[i].y - players[i].radius,
                     players[i].x + players[i].radius, players[i].y + players[i].radius); //leftX, topY, rightX, bottomY
      Canvas.Fill;
    end;
  {Draw platforms}
  for k := 0 to 3 do
    begin
      Canvas.FillStyle := 'black';
      Canvas.FillRect(round(platforms[k].x), round(platforms[k].y), round(platforms[k].width),
                      round(platforms[k].height));
    end;
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

{TPlayer constructor}
constructor TPlayer.Create(newX, newY, newR, newLk, newRk, newJk: integer; newColour: string);
begin
  x := newX;
  y := newY;
  radius := newR;
  leftKey := newLk;
  rightKey := newRk;
  jumpKey := newJk;
  xSpeed := 0;
  ySpeed := 0;
  grav := 0;
  colour := newColour;
end;

{TPlatform constructor}
constructor TPlatform.create(newX, newY, newW, newH : real);
begin
  x := newX;
  y := newY;
  width := newW;
  height := newH;
end;

end.