unit checks;
{
    Copyright (c) 2011 Steven Binns

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted for Smart Mobile Studio by PPS
}


interface

uses
  w3system, globals;

procedure Check_Collisions(level, mousex, mousey : integer);
function Collision_Circle(x1, y1, r1, x2, y2, r2 : integer) : boolean;
procedure enemcollisioncheck(excluded : integer);

var
  x1, y1, r1, x2, y2, r2, i : integer;

implementation

procedure enemcollisioncheck(excluded : integer); //checks whether enemies have collided with something
var
  i : integer;

begin
  for i := 0 to 20 do //for each of the possible enemies
    begin
      if i <> excluded then //if it isn't the one being checked
        begin
          if mobs[excluded, 4] = 1 then  //if the one being checked is chasing you
            begin
              if mobs[i, 4] = 1 then //if the current enemy exists
                begin
                  if Collision_Circle(mobsx[excluded], mobsy[excluded], mobs[excluded, 3],
                                      mobsx[i], mobsy[i], mobs[i, 3]) = true then //run circle collision algorithm
                    begin
                      mobs[excluded, 3] += mobs[i, 3]; //'absorb' the current enemy, increasing the radius of the enemy being checked
                      //destroy the current enemy since it has been 'absorbed'
                      mobsx[i] := 0;
                      mobsy[i] := 0;
                      mobs[i, 0] := 0;
                      mobs[i, 1] := 0;
                      mobs[i, 2] := 0;
                      mobs[i, 3] := 0;
                      mobs[i, 4] := 0;
                      exit;
                    end;
                end;
            end;
        end;
    end;
end;

procedure Check_Collisions(level, mousex, mousey : integer); //check whether ANYTHING has collided
var
  i : integer;

begin
  for i := 0 to 20 do
    begin
      if mobs[i, 0] = 1 then //if the current enemy exists
        begin
          if Collision_Circle(mobsx[i], mobsy[i], mobs[i, 3], mousex, mousey, level) = true //if the enemy's aggro circle has collided with yours
            then
              begin
                mobs[i, 4] := 1; //make it chase you
              end;
          if Collision_Circle(mobsx[i], mobsy[i], mobs[i, 3] DIV 2, mousex, mousey, level DIV 5) = true then //if the enemy's body has collided with yours
            begin
              stop := true //start the losing sequence
            end;
        end;
    end;
end;

function Collision_Circle(x1, y1, r1, x2, y2, r2 : integer): boolean; //circle collision algorithm
var
  finx, finy: integer;
begin
   finx := x1 - x2; //the horizontal distance between the targets
   finy := y1 - y2; //the vertical distance between the targets

   //if the true distance between the targets is smaller than the radii of the two targets combined
   if sqr(finx) + sqr(finy) <= sqr(r1 + r2) then
     begin
       result:= TRUE; //return true (they have collided)
     end
   else  //if the true distance is larger than the combined radii
     begin
       result := FALSE; //return false(they have not collided)
     end;
  end;

end.
