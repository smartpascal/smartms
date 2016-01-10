unit Unit1;
{
    Single platform and player version of
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
     player: TPlayer;
     platform: TPlatform;
     collision: boolean;
     gvWidth, gvHeight: integer;
     function checkVCollision: boolean;
     function checkHCollision: boolean;
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
function TCanvasProject.checkVCollision: boolean;
  function hAlignment: boolean;  //Nested function
  // If player's right extremity to right of left edge of platform and player's
  // left extremity to left of right edge of platform then return true.
  begin
    result := false;
    if (player.x + player.radius > platform.x) and
       (player.x - player.radius < platform.x + platform.width) then
      result := true;
  end;
begin
  result := false;
  //If ascending and horizontally aligned and top of player under bottom of
  // platform and next move would enter platform then return true.
  if (player.ySpeed > 0) and hAlignment and
     (player.y - player.radius > platform.y + platform.height) and
     (player.y - player.yspeed - player.radius < platform.y + platform.height) then
     result := true;
  // If descending and horizontally aligned and bottom of player under top of
  // platform and next move would enter platform then return true.
  if (player.yspeed < 0) and hAlignment and
    (player.y + player.radius < platform.y) and
    (player.y + player.radius - player.ySpeed > platform.y) then
    result := true;
  if (player.yspeed = 0) and hAlignment and
     (player.y + player.radius = platform.y) and
     (player.y + player.radius + 1 > platform.y) then
    result := true;
end;

function TCanvasProject.checkHCollision: boolean;
  function vAlignment: boolean;  //Nested function
  begin
    result := false;
    if (player.y - player.radius < platform.y + platform.height) and
       (player.y + player.radius > platform.y) then
      result := true;
  end;
begin
  result := false;
  //If moving right and vertically aligned and
  //player's right extremity to left or same as platform's left edge and
  //next move would enter platform then return true.
  if (player.xspeed > 0) and vAlignment and
     (player.x + player.radius <= platform.x) and
     (player.x + player.radius + player.xSpeed > platform.x) then
    result := true;
  //If moving left and vertically aligned and
  //player's left extremity to right or same as platform's right edge and
  //next move would enter platform then return true.
  if (player.xspeed < 0 ) and vAlignment and
     (player.x - player.radius >= platform.x + platform.width) and
     (player.x - player.radius + player.xspeed < platform.x + platform.width) then
    result := true;
end;
procedure TCanvasProject.KeyDownEvent(mCode: integer);
begin
  case mCode of
    player.leftKey: if player.moveRight = false then
                      player.moveLeft := true;
    player.rightKey: if player.moveLeft = false then
                      player.moveRight := true;
    player.jumpKey: if player.ySpeed = 0 then
                      player.ySpeed := 5;
    end;
end;

procedure TCanvasProject.KeyUpEvent(mCode: integer);
begin
  case mCode of
    player.leftKey: player.moveLeft := false;
    player.rightKey: player.moveRight := false;
  end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
   player := TPlayer.Create(150, 50, 5, 37, 39, 38, 'red'); //lKey:left rKey:right jKey:up
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
  platform := TPlatform.create(50, GameView.Height - 30, 20, 5);
  GameView.Delay := 10;
  GameView.StartSession(True);
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
begin
  // Player will gain speed up to a max value while key pressed.
  if (player.moveRight = true) and (player.xSpeed < 3) then
    player.xSpeed += 0.25;
  if (player.moveLeft = true) and (player.xSpeed > -3) then
    player.xSpeed -= 0.25;
  //Check for horizontal collision.
  collision := false;
  if checkHCollision = true then
    collision := true;

  if collision = false then  //Continue to move.
    player.x += player.xSpeed
  else //Horizontal collision
    begin  //Prevent player from entering platform and stop horizontal movement.
      if player.xSpeed > 0 then
        begin
          player.x := platform.x - player.radius;
          player.xSpeed := 0;
        end;
      if player.xSpeed < 0 then
        begin
          player.x := platform.x + platform.width + player.radius;
          player.xSpeed := 0;
        end;
    end;
  //Keep player horizontally in the GameView.
  if player.x + player.radius > gvWidth then
    player.x := gvWidth - player.radius;
  if player.x - player.radius < 0 then
    player.x := player.radius;
  //Create horizontal friction by reducing the speed.
  if (player.moveLeft = false) and (player.moveRight = false) then
    begin
      if player.xSpeed < 0 then
        player.xSpeed += 0.125
      else if player.xSpeed > 0 then
        player.xSpeed -= 0.125;
    end;
  //Deal with jumping and gravity
  collision := false;
  if checkVCollision = true then
    collision := true;

  if collision = false then
    begin
      player.y -= player.ySpeed;
      if player.y + player.radius < gvHeight then
        begin
          player.ySpeed -= player.grav;
          player.grav += 0.1;
        end
      else
        begin //Player has reached the floor so position it exactly on the floor.
          player.y := gvHeight - player.radius;
          player.ySpeed := 0;
          player.grav := 0;
        end;
    end
  else //vertical collision
    begin
      if player.ySpeed > 0 then  //Hits bottom of platform
        begin  //Position it just under platform.
          player.y := platform.y + platform.height + player.radius;
          player.ySpeed := 0;
          player.grav := 0;
        end;
      if player.yspeed < 0 then  //Hits top of platform
        begin   //Place it on platform.
          player.y := platform.y - player.radius;
          player.ySpeed := 0;
          player.grav := 0;
        end;
  end;
  // Clear background with colour gray.
  Canvas.FillStyle := 'gray';
  Canvas.FillRect(0, 0, gvWidth, gvHeight);
  //Draw circle for player.
  Canvas.FillStyle := player.colour;
  Canvas.BeginPath;
  Canvas.Ellipse(player.x - player.radius, player.y - player.radius,
                 player.x + player.radius, player.y + player.radius); //leftX, topY, rightX, bottomY
  Canvas.Fill;
  // Draw platform
  Canvas.FillStyle := 'black';
  Canvas.FillRect(round(platform.x), round(platform.y), round(platform.width),
                  round(platform.height));
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