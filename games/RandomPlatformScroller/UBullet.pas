unit UBullet;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system, UPlayer, UPlat, UE;

type TBullet = class(TObject)
  Shot : boolean; //True if the bullet is active
  Left : boolean; //True if the bullet is going left
  Angle : float; //The angle the bullet will travel at
  X : float;
  Y : float;
  Damage : integer; //How much damage the bullet will do
  FramesLeft : integer; //How many frames it has left (after hitting something)
                        //This is so that it does not just disappear, it shows it has hit it
  constructor create(isLeft : boolean; newX, newY : float; newDamage : integer; newAngle : float);
  procedure update(screenWidth : integer; player : TPlayer; Ais : array of TPlayer;
                   fixed, rands : array of TPlat);
  procedure Move();
  function HitPlayer(Player : TPlayer) : boolean;
  function HitPlat(Plat : TPlat) : boolean;
  function BulletBounds() : array [0 .. 1] of array [0 .. 1] of float;
  //First array: 0 = X Axis, 1 = Y Axis
  //Second array: 0 = Minimum Bound, 1 = Maximum Bound
end;

const
  WIDTH = 15; //The bullet's width
  HEIGHT = 5; //The bullet's Height

implementation

constructor TBullet.create(isLeft : boolean; newX, newY : float; newDamage : integer; newAngle : float);
begin
  Left := isLeft;
  X := newX;
  Y := newY;
  Shot := True;
  FramesLeft := 3;
  Damage := newDamage;
  Angle := newAngle;
end;

procedure TBullet.update(screenWidth : integer; player : TPlayer; Ais : array of TPlayer;
                         fixed, rands : array of TPlat);
var
  i : integer;
begin
  if Shot then //If the bullet is active, it will run code
    begin
      if (FramesLeft = 3) then //Only check collisions if it has got the maximum frames left, meaning
                               //it won't hit you through a platform or any other object
         begin
          while i <= High(fixed) do //iterate through the Fixed Platforms
            begin
              if HitPlat(fixed[i]) then
                begin
                  //If it has hit the Plat, make the frames left for the bullet to live 2
                  FramesLeft := 2;
                  //If the platform will crumble, make it fall
                  if fixed[i].Crumble then
                    begin
                      fixed[i].Crumbling := true;
                      fixed[i].TimeTillFall := CRUMBLE_DELAY;
                    end;
                end;
              i += 1; //Increases 'i' so that it will check the next platfrom
            end;
          i := 0;
          while i <= High(rands) do //iterate through the random platforms
            begin
              if HitPlat(rands[i]) then
                begin
                  //If it has hit the Plat, make the frames left for the bullet to live 2x
                  FramesLeft := 2;
                  //If the platfrom will crumble, make it fall
                  if rands[i].Crumble then
                    begin
                      rands[i].Crumbling := true;
                      rands[i].TimeTillFall := CRUMBLE_DELAY;
                    end;
                end;
              i += 1; //Increases i so that it will check the next platform
            end;
        end;
      if FramesLeft <> 3 then //If the frame is not equal to 3, decrease it
        begin
          FramesLeft -= 1;
        end;
      if FramesLeft <= 0 then //If the frame is 0, make the bullet inactive
        begin
          Shot := False;
        end;

      while Angle >= 360 do //Make the angle under 360, so a proper angle
        begin
          Angle -= 360;
        end;
      Move(); //Moves the bullet

      if (FramesLeft =3) then
        begin
          if HitPlayer(player) then //Checks if the bullet has hit the Player
            begin
              //If it hit the Player, it will make the frames left for the
              //bullet to live 2x as long as it is already at the max frames left
              //and also will damage the Player, and activate its knockback
              //and make it fly back in the correct direction
              player.KnockBackFrame := MAXKNOCKBACKFRAMES;
              player.KnockBackLeft := Left;
              player.Health -= Damage;
              FramesLeft := 2;
            end;
          i := 0;
          while i <= High(Ais) do //Iterate through the Ai Units (to be added)
            begin
              if HitPlayer(Ais[i]) then //Checks if the bullet has hit the selected Ai Unit
                begin
                  //If It hit the Ai unit, it will make the frames left for the
                  //bullet to live 2 as long as its already at the max frames left
                  //and also will damage the Ai, and activate its knockback
                  //and make it fly back in the correct direction
                  Ais[i].KnockBackFrame := MAXKNOCKBACKFRAMES;
                  Ais[i].KnockBackLeft := Left;
                  Ais[i].Health -= Damage;
                  FramesLeft := 2;
                end;
              i += 1; //Increases 'i' so it will check the next ai unit
            end;
          i := 0;
        end;
    end;

  //If the bullet is not active, it will send itself off screen so it cannot
  //get in the way.
  if Shot = False then
    begin
      X := -1000;
      Y := -1000;
    end;
end;

procedure TBullet.Move();
begin
  if Angle = 0 then //Move up if instructed to
    Y -= WIDTH
  else if Angle = 90 then //Move right if instructed to
    X += WIDTH
  else if Angle = 180 then //move down if instructed to
    Y += WIDTH
  else if Angle = 270 then //move left if instructed to
    X -= WIDTH
  else if Angle < 90 then //work out the x and y movement needed using trigonometry
    begin
      X += Sin(Angle * (PI / 180)) * WIDTH;
      Y -= Cos(Angle * (PI / 180)) * WIDTH;
    end
  else if Angle < 180 then
    begin
      X += Cos((Angle - 90) * (PI / 180)) * WIDTH;
      Y += Sin((Angle - 90) * (PI / 180)) * WIDTH;
    end
  else if Angle < 270 then
    begin
      X -= Sin((Angle - 180) * (PI / 180)) * WIDTH;
      Y += Cos((Angle - 180) * (PI / 180)) * WIDTH;
    end
  else if Angle < 360 then
    begin
      X -= Cos((Angle - 270) * (PI / 180)) * WIDTH;
      Y -= Sin((Angle - 270) * (PI / 180)) * WIDTH;
    end;
end;

function TBullet.HitPlayer(Player : TPlayer) : boolean;
var
  //If this is false, it won't bother checking the Y collision as it has already
  //failed the X collision, so it has not hit. This makes it more efficient.
  stillCheck : boolean;
begin
  stillCheck := false;

  //Sets the maximum and minimum x and y of the player, so it is ready to check
  var PlayerLeftX = Player.X;
  var PlayerRightX = Player.X + PLAYERHEAD;
  var PlayerTopY = Player.Y;
  var PlayerBottomY = Player.Y + PLAYERHEIGHT;

  //The following variable will contain the array of an array with
  //The upper and lower bounds of the x and y axis
  var Bounds = BulletBounds();

  //Tests the X collision
  if (Bounds[0][1] >= PlayerLeftX) and (Bounds[0][0] <= PlayerRightX) then
    stillCheck := true; //It it passed the x, it will then bother testing the y

  if stillCheck then
    begin
      //Test the y if the x has collided
      if (Bounds[1][0] <= PlayerBottomY) and (Bounds[1][1] >= PlayerTopY) then
         //It has collided with both x and y so has hit
         Exit(true);
    end;

  Exit(False); //If both haven't passed, this runs returning false.
end;

function TBullet.HitPlat(Plat : TPlat) : boolean;
var
  //If this is false, it won't bother checking the Y collision as it has already
  //failed the X collision, so it has not hit. This makes it more efficient.
  stillCheck : boolean;
begin
  stillCheck := false;

  //Sets the platform's minimum and maximum X and Y's
  var PlatLeftX = Plat.X;
  var PlatRightX = Plat.X + Plat.Width;
  var PlatTopY = Plat.Y;
  var PlatBottomY = Plat.Y + Plat.Height;

  //The following variable will contain the array of an array with
  //The upper and lower bounds of the x and y axis
  var Bounds = BulletBounds();

  //Tests the X collision
  if (Bounds[0][1] >= PlatLeftX) and (Bounds[0][0] <= PlatRightX) then
    stillCheck := true; //It it passed the x, it will then bother testing the y

  if stillCheck then
    begin
      //Test the y if the x has collided
      if (Bounds[1][0] <= PlatBottomY) and (Bounds[1][1] >= PlatTopY) then
         //It has collided with both x and y so has hit
         Exit(true);
    end;

  Exit(False); //If both havn't passed, this runs returning false
end;

function TBullet.BulletBounds() : array [0 .. 1] of array [0 .. 1] of float;
var
  //Will be used to form the 2D array
  BulletLeftX, BulletRightX, BulletTopY, BulletBottomY : float;
  //The returned 2D array
  Return : array [0 .. 1] of array [0 .. 1] of float;
begin
  //Works out the minimum and maximum X and Y of the bullet, depending on the angle
  if Angle = 0 then
    begin
      BulletLeftX := X;
      BulletRightX := X + HEIGHT;
      BulletTopY := Y;
      BulletBottomY := Y + WIDTH;
    end
  else if Angle = 90 then
    begin
      BulletLeftX := X;
      BulletRightX := X + WIDTH;
      BulletTopY := Y;
      BulletBottomY := Y + HEIGHT;
    end
  else if Angle = 180 then
    begin
      BulletLeftX := X;
      BulletRightX := X + HEIGHT;
      BulletTopY := Y;
      BulletBottomY := Y + WIDTH;
    end
  else if Angle = 270 then
    begin
      BulletLeftX := X;
      BulletRightX := X + WIDTH;
      BulletTopY := Y;
      BulletBottomY := Y + HEIGHT;
    end
  //Uses trigonometry for Angles that are not stright below
  //Angles under 90 and angles between 180 and 270
  else if (Angle < 90) or ((Angle >= 180) and (Angle < 270)) then
    begin
      var TempAngle := Angle; //Create a temp angle as it may need to be changed
                              //So its under 90 degrees
      if Angle >= 90 then
        TempAngle := Angle - 180;

     TempAngle *= (Pi / 180); //Convert the angle from degrees to radians
                            //as the Pascal trigonetry commands use radians

      BulletLeftX := X;
      BulletRightX := X + (Sin(TempAngle) * WIDTH) + (Cos(TempAngle) * HEIGHT);
      BulletTopY := Y - (Cos(TempAngle) * WIDTH);
      BulletBottomY := Y + (Sin(TempAngle) * HEIGHT);
    end
  else //Angles above 270 and angle between 90 and 180
    begin
      var TempAngle := Angle - 90; //Create a temp angle as it may need to be changed
                                   //So its under 90 degrees
      if Angle >= 180 then
        TempAngle := Angle - 270;

      TempAngle *= (Pi / 180); //Convert the angle from degrees to radians
                             //as the Pascal trigonetry commands use radians

      BulletLeftX := X;
      BulletRightX := X + (Sin(TempAngle) * HEIGHT) + (Cos(TempAngle) * WIDTH);
      BulletTopY := Y - (Cos(TempAngle) * HEIGHT);
      BulletBottomY := Y + (Sin(TempAngle) * WIDTH);
    end;

  Return[0][0] := BulletLeftX;
  Return[0][1] := BulletRightX;
  Return[1][0] := BulletTopY;
  Return[1][1] := BulletBottomY;

  Exit(Return);
end;

end.
