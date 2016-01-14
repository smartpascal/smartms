unit enemies;
{
    Copyright (c) 2011 Steven Binns

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted for Smart Mobile Studio by PPS
}

interface

uses
   w3system, checks, globals;

procedure Create_Enemy(level : integer);
procedure Tick_Enemies(mousex, mousey : integer);
procedure Move_Enemy(i, mousex, mousey : integer);

var
  //'i' is a generic count variable for loops
  //'whichside' is a variable determining which side of the screen an enemy spawns on
  whichside, finx, finy, finr: integer;
  done : boolean;

implementation

procedure Create_Enemy(level : integer);
var
  i : integer;
begin
  done := False;
  for i := 0 to 20 do
    begin
      if mobs[i, 0] = 0 then
        begin
          whichside := trunc(4 * random); //select which side the enemy will spawn
          case whichside of
            0 : begin
                  mobsx[i] := 0;          //at the very left of the screen
                  mobsy[i] := trunc(401 * random); //somewhere along the left border
                  done := True;
                  mobs[i, 0] := 1;        //create the enemy
                  mobs[i, 1] := trunc(3 * random);    //horizontal speed
                  mobs[i, 2] := trunc(5 * random - 2);//vertical speed
                  mobs[i, 3] := level + 3;       //sets the radius of the enemy
                  mobs[i, 4] := 0;             //Not chasing
                end;
            1 : begin
                  mobsx[i] := 400;         //at the very right of the screen
                  mobsy[i] := trunc(401 * random); //somewhere along the right border
                  done := True;
                  mobs[i, 0] := 1;
                  mobs[i, 1] := trunc(3 * random - 2);
                  mobs[i, 2] := trunc(5 * random - 2);
                  mobs[i, 3] := level + 3;
                  mobs[i, 4] := 0;
                end;
            2 : begin
                  mobsx[i] := trunc(401 * random);//somewhere along the top border
                  mobsy[i] := 0;                  //at the very top of the screen
                  done := True;
                  mobs[i, 0] := 1;
                  mobs[i, 1] := trunc(5 * random - 2);
                  mobs[i, 2] := trunc(3 * random);
                  mobs[i, 3] := level + 3;
                  mobs[i, 4] := 0;
                end;
            3 : begin
                  mobsx[i] := trunc(401 * random);//somewhere along the bottom border
                  mobsy[i] := 400;        //at the very bottom of the screen
                  done := True;
                  mobs[i, 0] := 1;
                  mobs[i, 1] := trunc(5 * random - 2);
                  mobs[i, 2] := trunc(3 * random - 2);
                  mobs[i, 3] := level + 3;
                  mobs[i, 4] := 0;
                end;
          end; //of case
        end; //of if
        if done = True then
          exit;
    end; //of for
end;  //of proc

procedure Tick_Enemies(mousex, mousey : integer); //deal with the enemies for the current tick
var
  i : integer;
begin
  for i := 0 to 20 do //for each of the enemies possible
    begin
      checks.enemcollisioncheck(i); //check whether there are any collisions
      if mobs[i, 0] = 1 then //if the enemy exists
        begin
          if (mobs[i, 1] = 0) and (mobs[i, 2] = 0) then //if the x-speed and y-speed are 0
            begin
              //delete the enemy
              mobsx[i] := 0;
              mobsy[i] := 0;
              mobs[i, 0] := 0;
              mobs[i, 1] := 0;
              mobs[i, 2] := 0;
              mobs[i, 3] := 0;
              mobs[i, 4] := 0;
            end;
          Move_Enemy(i, mousex, mousey); //move the enemy
          if (mobsx[i] > 400) or (mobsy[i] > 400) or
             (mobsx[i] < 0) or (mobsy[i] < 0)   then  //if it is off the screen
            begin
              mobsx[i] := 0;
              mobsy[i] := 0;
              mobs[i, 0] := 0;
              mobs[i, 1] := 0;
              mobs[i, 2] := 0;
              mobs[i, 3] := 0;
              mobs[i, 4] := 0;
            end;
        end;
    end;
end;

procedure Move_Enemy(i, mousex, mousey : integer);
begin
  if mobs[i, 4] = 0 then //if the enemy isn't chasing you
    begin
      mobsx[i] := mobsx[i] + mobs[i, 1]; //move its x position by its horizontal speed
      mobsy[i] := mobsy[i] + mobs[i, 2]; //move its y position by its vertical speed
    end
  else //if it is chasing you
    begin
      if mousex < mobsx[i] then //if the mouse is to its left
        dec(mobsx[i])           //move left by 1 position
      else if mousex > mobsx[i] then //if the mouse is to its right
        inc(mobsx[i]);               //move right by 1 position
      if mousey < mobsy[i] then //if the mouse is above it
        dec(mobsy[i])           //move up by one position
      else if mousey > mobsy[i] then //if the mouse is below it
        inc(mobsy[i]);               //move down by one position
      enemcollisioncheck(i);    //check whether the chaser has reached you (check its collisions)
    end;
end;

end.