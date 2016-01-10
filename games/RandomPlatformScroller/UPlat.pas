unit UPlat;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system, UE, UGlobalsNoUserTypes;

const
  CRUMBLE_DELAY = 20;
  MOVE_SPEED_INC = 0.5;
  MOVE_SPEED_MAX = 5;

type TPlat = class(TObject)
  X, Y : float; //X and Y co-ordinates
  Width, Height : float;
  GravSpeed : float; //How fast the gravity is
  XMove,YMove : float; //How much the platform can move in the x and y direction
  XMoved,YMoved : float; //How much the platform has moved in the x and y directions
  InitX,InitY : float; //The initial x and y
  MovingX,MovingY : boolean; //If the platform is moving in the x or y direction
  MoveSpeed : float; //How fast the platform it moving
  TimeTillFall : integer; //Time left till the platform will fall
  horizontal, jumpThrough, noFall, NoWallJump, Crumble, Crumbling, Moves : boolean; //Possible properties of the platform
  turretOnLeftOrTop, turretOnRightOrBottom : boolean; //If the platform is on the Left/Top side or the Right/Bottom side
  constructor createR(ScreenWidth, ScreenHeight, PHeight, PWidth : integer;
              Door1, Door2 : UE.TE; Rand, Fix : array of TPlat; verticals, through, fall, noWallJumps,
              crumbles, Movers, MoversLtoR, MaximumMove, onToporLefts, onBottomorRights  : float = 0);
  constructor createF(newX, newY, newWidth, newHeight : integer; ThroughorWallJump, fall, willCrumble, //Through or no Wall Jump is so that
                                                                                                       //if its a vertical it will disable wall jumps if its
                                                                                                       //true instead of making a new paramiter
                    	willMove, MovesUp : boolean = false; MaxMove : integer = 0;
                      onTopOrLeft, onBottomOrRight : boolean = false);
  procedure CrumbleUpdate();
  function MoveUpdate(px, py, px2, py2 : float) : array [0..1] of float; //returns a vector to move the player x and y
  function PlayerCollidesPlat(px, py, px2, py2 : float) : boolean;
  function collidesWithDoor(Door : TE) : boolean;
  function collidesWithPlat(Plat : TPlat) : boolean;
end;

implementation

constructor TPlat.createF(newX, newY, newWidth, newHeight : integer; ThroughorWallJump, fall, willCrumble,
                          willMove, MovesUp : boolean = false; MaxMove : integer = 0;
                          onTopOrLeft, onBottomOrRight : boolean = false);
begin
  X := newX;
  Y := newY;
  Width := newWidth;
  Height := newHeight;
  jumpThrough := ThroughorWallJump;
  NoWallJump := false;
  noFall := fall;
  Crumble := willCrumble;
  if Width < Height then //if it is vertical
    begin
      horizontal := false;
      jumpThrough := false;
      NoWallJump := ThroughorWallJump; //Only verticals can be wall jump platforms
      jumpThrough := false;
    end
  else
    horizontal := true;
  GravSpeed := 0;
  TimeTillFall := 0;
  Moves := willMove;
  InitX := newX;
  InitY := newY;
  if Moves then
    begin
      if MovesUp then
        begin
          MovingX := false;
          MovingY := true;
          XMove := 0;
          YMove := MaxMove;
          InitY := newY + (MaxMove/2);
        end
      else
        begin
          MovingX := true;
          MovingY := false;
          XMove := MaxMove;
          YMove := 0;
          InitX := newX + (MaxMove/2);
        end;
      XMoved := 0;
      YMoved := 0;
    end;
  MoveSpeed := 0;

  if onTopOrLeft then
    turretOnLeftOrTop := true;
  if onBottomOrRight then
   turretOnRightOrBottom := true;
end;

constructor TPlat.createR(ScreenWidth, ScreenHeight, PHeight, PWidth : integer;
                          Door1, Door2 : UE.TE; Rand, Fix : array of TPlat; verticals, through, fall, NoWallJumps,
                          crumbles, Movers, MoversLtoR, MaximumMove, onToporLefts, onBottomorRights : float = 0);
const
  MAX_TRIES = 10; //How many times it will try to spawn
var
  i : integer;
  Spawned : boolean;
  howMany : integer;
  vertical : integer;
begin
  vertical := randomint(100); //This will pick a random number
  if vertical < verticals then //if it is below the verticals percentage, it is vertical
    horizontal := False
  else
    horizontal := True;

  //Runs a spawning procedure if it is a horizontal platform
  if horizontal = True then
    begin
      while Spawned = False do //Keeps spawning till it is not overlapping anything
        begin
          //Spawns a platform on the screen if it is not under the max_Tries
          if howMany <= MAX_TRIES then
            begin
              //Picks a random x position on the screen
              X := randomint(ScreenWidth);
              //Picks a random Y position on the screen, then adds
              //75 so the player can use it
              Y := randomint(ScreenHeight - 75) + 75;
              //picks a width between 50 and 200
              Width := randomint(150) + 50;
              Height := 10;
              Spawned := True;
            end
          //Otherwise it will try off screen too, meaning it is struggling to spawn
          //so it basically skips it
          else
            begin
              //Picks a random x position
              X := randomint(ScreenWidth + 10000);
              //Picks a random Y position
              Y := randomint(ScreenHeight + 10000);
              //Adds 75 so the player can jump on it
              Y += 75;
              //Picks a width between 50 and 200
              Width := randomint(150) + 50;
              Height := 10;
              Spawned := True;
            end;
          if Spawned = True then
            begin
              if collidesWithDoor(Door1) then //Checks if it overlapped with the door
              begin
                Spawned := False; //If it failed it will say it failed to spawn
                howMany += 1; //Adds a try so it can count how many times it has failed
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              if collidesWithDoor(Door2) then //Checks if it overlapped with the door
                begin
                  Spawned := False; //If it failed it will say it failed to spawn
                  howMany += 1; //Adds a try so it can count how many times it has failed
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              for i := 0 to High(Fix) do //Iterates through the fixed plats
                begin
                  if collidesWithPlat(Fix[i]) then //checks if it overlapped
                    begin
                      Spawned := False; //If it failed it will say it failed to spawn.
                      howMany += 1; //Adds a try so it can count how many times it has failed.
                    end;
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              for i := 0 to High(Rand) do //iterates through the random plats
                begin
                  //Checks if it is horizontal as it is allowed to spawn over verticals
                  if Rand[i].horizontal = True then
                    begin
                      if collidesWithPlat(Rand[i]) then //checks if it overlapped
                        begin
                          Spawned := False; //If it failed it will record it failed to spawn
                          howMany += 1; //Adds a try so it can count how many times it has failed
                        end;
                    end;
                end;
            end;
        end;
    end;
  //If it was selected vertical it will run the vertical spawning code
  if horizontal = False then
    begin
      while Spawned = False do //Keeps spawning till it is not overlapping anything
        begin
          //Spawns a platform on the screen if it is not under the max_Tries
          if howMany <= MAX_TRIES then
            begin
              //Picks a random x position on the screen
              X := randomint(ScreenWidth);
              //Picks a random Y position on the screen, then adds
              //75 so the player can use it
              Y := randomint(ScreenHeight - 75) + 75;
              Width := 10;
              //Sets the height to something between 50 and 200
              Height := randomint(150) + 50;
              Spawned := True;
            end
          //Otherwise it will try off screen too, meaning it is stuggling to spawn
          //so it basically skips it
          else
            begin
              //Picks a random x position
              X := randomint(ScreenWidth + 10000);
              //Picks a random Y position
              Y := randomint(ScreenHeight + 10000);
              //adds 75 so the player can use it
              Y += 75;
              Width := 10;
              //Sets the height to something between 50 and 200
              Height := randomint(150) + 50;
              Spawned := True;
            end;
          if Spawned = True then
            begin
              if collidesWithDoor(Door1) then //checks if it overlapped with the door
                begin
                  Spawned := False; //If it failed it will record that it failed to spawn
                  howMany += 1; //Adds a try so it can count how many times it has failed
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              if collidesWithDoor(Door2) then //checks if it overlapped with the door
                begin
                  Spawned := False; //If it failed it will say it failed to spawn
                  howMany += 1; //Adds a try so it can count how many times it has failed
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              for i := 0 to High(Fix) do //Iterates through the fixed platforms
                begin
                  if collidesWithPlat(Fix[i]) then //checks if it overlapped
                    begin
                      Spawned := False; //If it failed it will say it failed to spawn
                      howMany += 1; //Adds a try so it can count how many times it has failed
                    end;
                end;
            end;
          if Spawned = True then //Only works if the previous things worked
            begin
              for i := 0 to High(Rand)do //Iterates through the Random platforms
                begin
                  //Checks if it is vertical  as it is allowed to spawn over horizontal
                  if Rand[i].horizontal = False then
                    begin
                      if collidesWithPlat(Rand[i]) then //checks if it overlapped
                        begin
                          Spawned := False; //If it failed it will say it failed to spawn
                          howMany += 1; //Adds a try so it can count how many times it has failed
                        end;
                    end;
                end;
            end;
        end;
    end;

  var canNotFall := randomint(100); //Picks a random number
  if (canNotFall < fall) then //if the number is below the percentage of noFall plats turn off falling
    noFall := true
  else
    noFall := false;

  var canJumpThrough := randomint(100); //picks a random number
  if (canJumpThrough < through) and (horizontal) then //if the number is below the percentage of jumpThrough plats turn on jumpThrough
                                                      //and not vertical to avoid bugs
    jumpThrough := true
  else
    jumpThrough := false;

  var canWallJump := randomint(100); //picks a random number
  if (canWallJump < noWallJumps) and (horizontal = false) then //if the number is below the percentage of noWallJump plats turn off wall
                                                               //jumps and it must not be horizontal as you can always wall jump off a horizontal
    NoWallJump := true
  else
    NoWallJump := false;

  var willCrumble := randomint(100); //picks a random number
  if willCrumble < crumbles then //if the number is below the percentage of crumble plats turn on crumbling
    Crumble := true
  else
    Crumble := false;

  var willMove := randomint(100); //picks a random number
  if willMove < Movers then //if the number is below the percentage of moving plats it will move
    Moves := true
  else
    Moves := false;

  var MAXMOVING := randomint(Trunc(MaximumMove)); //picks a random number under the max move allowed
  var willMoveonX := randomint(100); //picks a random number
  if willMoveonX < MoversLtoR then //if the number is below the percentage of Xmove plats it will move on the X axis
    begin
      MovingX := true;
      XMove := MAXMOVING;
    end
  else
    begin
      MovingY := true;
      YMove := MAXMOVING;
    end;
  InitX := X + (XMove / 2); //sets the centre x
  InitY := Y + (YMove / 2); //sets the centre y

  var TurretProb := random * 100; //Picks a random number
  if TurretProb < onToporLefts then //Spawn a turret on the left or top if it was under the percentage for the amount of
                                    //turrets on the left or top sides
    turretOnLeftOrTop := true;
  TurretProb :=  random * 100; //Picks a random number again
  if TurretProb < onBottomorRights then //Spawn a turret on the right or bottom if it was under the
                                        //percentage for the amount of turrets on the right or bottom sides
    turretOnRightOrBottom := true;
end;

procedure TPlat.CrumbleUpdate();
begin
  if Crumbling then
    begin
      if TimeTillFall > CRUMBLE_DELAY then
        begin
          GravSpeed += 1;
          Y += GravSpeed;
        end;
      inc(TimeTillFall);
    end;
end;

function TPlat.MoveUpdate(px, py, px2, py2 : float) : array [0 .. 1] of float; //Updates moving platforms
var
  Return : array [0 .. 1] of float;
begin
  if (Moves) and (Crumbling = false) then //Only run if it moves and is not crumbling
    begin
      if MovingX then //runs code for if the plat is moving on the X axis
        begin
          if MoveSpeed > 0 then //If the moving speed is positive
            begin
              if XMoved >= XMove/2 - Width then //If the current location is over the max
                MoveSpeed -= MOVE_SPEED_INC //decrease the moving speed
              else
                MoveSpeed += MOVE_SPEED_INC; //otherwise increase it

              if MoveSpeed > MOVE_SPEED_MAX then //If the movespeed is over its max
                begin
                  MoveSpeed := MOVE_SPEED_MAX; //make it equal to the max
                end;
              XMoved += MoveSpeed; //Add the movespeed to the amount of x moved
              X := InitX + XMoved; //set the plat's x
              if PlayerCollidesPlat(px, py, px2, py2) then //Adds the move speed and moves the player x if it is on the plat
                Return[0] := MoveSpeed;
            end
          else //Otherwise
            begin
              if XMoved <= -XMove/2 then //if the amount moved is under the minimum
                MoveSpeed += MOVE_SPEED_INC //make it move right
              else
                MoveSpeed -= MOVE_SPEED_INC; //otherwise make it speed up going left

              if MoveSpeed <= -MOVE_SPEED_MAX then //if the movespeed it over its max
                MoveSpeed := -MOVE_SPEED_MAX; //make it equal to the max

              XMoved += MoveSpeed; //add the movespeed to the max (actually decreasing the moved amount)
              X := InitX + XMoved; //set the x
              if PlayerCollidesPlat(px, py, px2, py2) then //Adds the move speed and moves the player x if it is on the plat
                Return[0] := MoveSpeed;
            end;
        end
      else if MovingY then //run code if the y is moving
        begin
          if MoveSpeed > 0 then //If the movespeed is positive
            begin
              if YMoved >= YMove/2 - Height then //if the amount moved is over its max
                MoveSpeed -= MOVE_SPEED_INC //decrease the movespeed
              else
                MoveSpeed += MOVE_SPEED_INC; //otherwise keep increasing it

              if MoveSpeed > MOVE_SPEED_MAX then //if the movespeed is over its max speed
                begin
                  MoveSpeed := MOVE_SPEED_MAX; //set the movespeed it its max
                end;
              YMoved += MoveSpeed; //add the movespeed to the amount moved
              Y := InitY + YMoved; //set the y
              if PlayerCollidesPlat(px, py, px2, py2) then //Adds the move speed and moves the player y if it is on the plat
                Return[1] := MoveSpeed;
            end
          else //otherwise if the movespeed is negative
            begin
              if YMoved <= -YMove/2 then //If the amount  moved is under its minimum
                MoveSpeed += MOVE_SPEED_INC //increase the speed (start making it positive)
              else
                MoveSpeed -= MOVE_SPEED_INC; //otherwise keep decreasing it

              if MoveSpeed <= -MOVE_SPEED_MAX then //if the movespeed is its max (or more)
                MoveSpeed := -MOVE_SPEED_MAX; //make it equal to its max move speed

              YMoved += MoveSpeed; //add the movespeed the amount moved (decreasing it)
              Y := InitY + YMoved; //set the y
            end;
        end;
    end;
    Exit(Return);
end;


function TPlat.PlayerCollidesPlat(px, py, px2, py2 : float) : boolean;
begin
  if (px2 > X) and (px2 < X + Width) then //Checks if the X overlap
    begin
      //Has some leniency on the upper bound of the collision so that it will
      //definitely pick up the player so that it can stay on the platform as it moves down
      if (py2 >= Y - 6) and (py < Y + Height) then //checks if the y overlap
        Exit(true); //if both pass, it collides
    end;
  Exit(false); //otherwise it didn't
end;

function TPlat.collidesWithDoor(Door : TE) : boolean;
var
  //If it picks up the x does not conflict, it will not bother with
  //the y as this will be false
  stillCheck : boolean;
begin
  stillCheck := false;

  //Testing X overlap:
  //Tests if the right hand side is overlapping the door
  if (X + Width <= Door.X + UE.WIDTH) and (X + Width >= Door.X) then
    begin
      stillCheck := true;  //The X overlapped, so still need to test the y
    end
  //Tests if the left hand side is overlapping the door
  else if (X <= Door.X + UE.WIDTH) and (X >= Door.X) then
    begin
      stillCheck := true;  //The X overlapped, so still need to test the y
    end
  //Tests if it is spawning over the door
  else if (X <= Door.X) and (X + Width >= Door.X + UE.WIDTH) then
    begin
      stillCheck := true;  //The X overlapped, so still need to test the y
    end;

  if stillCheck then   //It will only test the y is it overlapped with the x
    begin
      //Tests Y:
      //Tests if the bottom is overlapping the door
      if (Y + Height <= Door.Y + UE.HEIGHT) and (Y + Height >= Door.Y) then
        begin
          Exit(True);  //It collided with both x and y so overlaps
        end
      //Tests if the top is overlapping the door
      else if (Y <= Door.Y + UE.HEIGHT) and (Y >= Door.Y) then
        begin
          Exit(True);  //It collided with both x and y so overlaps
        end
      //Test if it is spawning over the door
      else if (Y + Height >= Door.Y) and (Y <= Door.Y) then
        begin
          Exit(True);  //It collided with both x and y so overlaps
        end
    end;

  Exit(False);  //It didn't overlap on both, so it doesn't overlap so returns false.
end;

function TPlat.collidesWithPlat(Plat : TPlat) : boolean;
var
  //If it picks up that the x doesn't conflict, it won't bother
  //with the y as this will be false.
  stillCheck : boolean;
begin
  stillCheck := false;

  //Checks the X:
  //Tests if the right side spawns over the platform with
  //some extra room for the player
  if (X + Width <= Plat.X + Plat.Width + (2 * PLAYERHEAD)) and
     (X + Width >= Plat.X - (2 * PLAYERHEAD)) then
    begin
      stillCheck := true; //X overlapped so need to test the Y
    end
  //Tests if the left side spawns over the platform with
  //some extra room for the player
  else if (X <= Plat.X + Plat.Width + (2 * PLAYERHEAD)) and
          (X >= Plat.X - (2 * PLAYERHEAD)) then
    begin
      stillCheck := true; //X overlapped so need to test the Y
    end
  //Tests if the platform spawns over the other platform with
  //some extra room for the player
  else if (X + Width >= Plat.X + Plat.Width + (2 * PLAYERHEAD)) and
          (X <= Plat.X - (2 * PLAYERHEAD)) then
    begin
      stillCheck := true; //X overlapped so need to test the Y
    end;

  if stillCheck then  //if it overlapped x, it is only then worth testing y
    begin
      //Tests Y:
      //Tests if the bottom spawns over the platform with some
      //extra room for the player
      if (Y + Height <= Plat.Y + Plat.Height + ((4 / 3) * (PLAYERHEIGHT))) and
         (Y + Height >= Plat.Y - ((4 / 3) * (PLAYERHEIGHT))) then
        begin
          Exit(True) //It collided with both x and y so overlaps
        end
      //Tests if the top spawns over the platform with some
      //extra room for the player
      else if (Y <= Plat.Y + Plat.Height + ((4 / 3) * (PLAYERHEIGHT))) and
              (Y >= Plat.Y - ((4 / 3) * (PLAYERHEIGHT))) then
        begin
          Exit(True) //It collided with both x and y so overlaps
        end
      //Tests if the platform spawns over the other platform with some
      //extra room for the player
      else if (Y + Height >= Plat.Y + Plat.Height + ((4 / 3) * (PLAYERHEIGHT))) and
              (Y <= Plat.Y - ((4 / 3) * (PLAYERHEIGHT))) then
        begin
          Exit(True) //It collided with both x and y so overlaps
        end;
    end;

  Exit(False);  //It did not overlap both times, so does not overlap
end;

end.
