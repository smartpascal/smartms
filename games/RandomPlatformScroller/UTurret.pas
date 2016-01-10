unit UTurret;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System, UBullet, UPlayer, UPlat, UGlobalsNoUserTypes;

type
  SidePlacedOn = (Left, Right, Top, Bottom);

const
  WIDTH = TURRET_WIDTH;
  HEIGHT = TURRET_HEIGHT;
  MAXTIMESSHOT = 2;
  MINTIMETILLSHOOT = 20;

type
  TTurret = class(TObject)
  X, Y : float; //The x and y position of the turret
  GravSpeed : float; //The speed it falls at after it has been shot down
  Angle : float; //The angle it is aiming it
  Placement : SidePlacedOn; //What side it will be placed on
  ShotsTillDead : integer; //How many times it can be shot till it dies
  TimeTillShoot : integer; //How many frames till it can shoot again
  isRand : boolean; //If the platform it is on is random platform
  PlatID : integer; //The ID number of the platform
  constructor Create(newX, newY, newAngle : float; Side : SidePlacedOn);
  procedure Update(player : TPlayer; Bullets : array of TBullet; Ais : array of TPlayer; FixedPlats, RandPlats : array of TPlat);
  procedure BulletHit(Bullet : TBullet); //Changes values on the bullet if it the turret
  procedure SetOnPlatform(Plat : TPlat); //Puts the Turret on the correct platforn in the right place
  procedure HasBeenHit(Bullets : array of TBullet); //Checks if a bullet has hit it
  function ShouldShoot(player : TPlayer; Ais : array of TPlayer; FixedPlats,
                       RandPlats : array of TPlat; TargetAngle : float) : boolean; //Checks if it should shoot (if it would hit the player)
  function getTargetAngle(player : TPlayer) : float; //Gets the target angle needed
end;

implementation

constructor TTurret.Create(newX, newY, newAngle : float; Side : SidePlacedOn);
begin
  X := newX;
  Y := newY;
  GravSpeed := -4; //So that when it is shot down, it jumps up slightly then falls
  Angle := newAngle;
  Placement := Side;
  ShotsTillDead := MAXTIMESSHOT;
  TimeTillShoot := 0;
end;

procedure TTurret.Update(player : TPlayer; Bullets : array of TBullet; Ais : array of TPlayer; FixedPlats, RandPlats : array of TPlat);
var
  //This is the target angle, that will hit the Player
  TargAngle : float;
begin
  if (ShotsTillDead <= 0) and (Y <= maxY + 2500) then //If the turret is dead:
    begin
      Y += GravSpeed; //Make the Y go down, so it falls
      GravSpeed += 1; //Increase the gravity speed
	  end
  else if ShotsTillDead > 0 then
    begin
      Angle := round(Angle) mod 360;
      //Uses the procedure to get the target angle
      TargAngle := getTargetAngle(player);
      if TargAngle < 0 then
        TargAngle := 360 - TargAngle;
      TargAngle := round(TargAngle) mod 360;
      //Change the angle so it gets closer to the target angle gradually
      if Placement = Bottom then //It will bug out as it skips from 0 deg to 359 degrees
                                 //so this is a separate bit of code that will inverse
                                 //the angles and act upon those, so no bugging out
        begin
          var ReverseTargAngle : float;
          var ReverseAngle : float;

          //Reverse the Target Angle
          if TargAngle >= 180 then
            ReverseTargAngle := 270 - (TargAngle - 270)
          else
            ReverseTargAngle := 90 + (90 - TargAngle);

          //Reverse the Angle
          if Angle >= 180 then
            ReverseAngle := 270 - (Angle - 270)
          else
            ReverseAngle := 90 + (90 - Angle);

          //Adjust the angle of the turret
          if ReverseTargAngle > ReverseAngle then
            begin
              if ReverseTargAngle - ReverseAngle < 1.5 then //This is so that it slowly moves round
                                                            //rather than just jump to the correct angle
                Angle := TargAngle
              else
                Angle -= 2;
            end
          else
            begin
              if ReverseAngle - ReverseTargAngle < 1.5 then //This is so that it slowly moves round
                                                            //rather than just jump to the correct angle
                Angle := TargAngle
              else
                Angle += 1.5;
            end;
        end
      //Adjust the angle of the turret
      else if TargAngle > Angle then
        begin
          if TargAngle - Angle < 1.5 then //This is so that it slowly moves round
                                          //rather than just jump to the correct angle
            Angle := TargAngle
          else
            Angle += 1.5;
        end
      else
        begin
          if Angle - TargAngle < 1.5 then //This is so that it slowly moves round
                                          //rather than just jump to the correct angle
            Angle := TargAngle
          else
            Angle -= 2;
        end;

      //If it is trying to move too far for its reach, set it to its maximum/minimum
      //angle for its placement
      Case Placement of
          Left : begin
                   if Angle < 0 then
                     Angle := 0;
                   if Angle > 180 then
                     Angle := 180;
                 end;
          Right : begin
                    if Angle > 360 then
                      Angle := 360;
                    if Angle < 180 then
                      Angle := 180;
                  end;
          Top : begin
                  if Angle > 270 then
                    Angle := 270;
                  if Angle < 90 then
                    Angle := 90;
                end;
          Bottom : begin
                     if ((Angle < 270) and (Angle >= 180)) or (Angle < -90) then //In case the angle doesn't skip to 360 when it becomes negative
                       Angle := 270;
                     if (Angle > 90) and (Angle < 180) then
                       Angle := 90;
                   end;
        end;

        if (ShouldShoot(player, Ais, FixedPlats, RandPlats, TargAngle)) and (TimeTillShoot < 0) then
          begin
            var i := -1;
            repeat
              i += 1;
            until (Bullets[i].Shot = false) or (i >= High(Bullets));

            if i >= High(Bullets) then
              i := High(Bullets) + 1;

            if Angle >= 180 then
              begin
                Bullets[i] := UBullet.TBullet.create(true, X + WIDTH/2 - UBullet.HEIGHT - 1, Y + HEIGHT/2, 15, Angle)
              end
            else
                Bullets[i] := UBullet.TBullet.create(false, X + WIDTH/2 - UBullet.HEIGHT - 1, Y + HEIGHT/2, 15, Angle);
            TimeTillShoot := MINTIMETILLSHOOT + 1;
            Bullets[i].update(maxX,player,Ais,FixedPlats,RandPlats); //Update the bullet so it moves and the turret has not shot itself
            Bullets[i].update(maxX,player,Ais,FixedPlats,RandPlats);
            Bullets[i].update(maxX,player,Ais,FixedPlats,RandPlats);
          end;

          dec(TimeTillShoot); //Decrease the time till shoot so it can shoot again after it reaches 0

        //Checks if its been hit by a bullet. Done in this unit as due to the referencing, the bullet unit
        //can not as it will cause a circular unit reference
        HasBeenHit(Bullets);

        //Puts the turret on the platform correctly
        if isRand then
          SetOnPlatform(RandPlats[PlatID])
        else
          SetOnPlatform(FixedPlats[PlatID]);
    end;
end;

procedure TTurret.SetOnPlatform(Plat : TPlat);
begin
  if Placement = Bottom then //Put the turret on the centre top of the platform
    begin
      X := Plat.X + (Plat.Width / 2) - (WIDTH / 2);
      Y := Plat.Y - HEIGHT;
    end
  else if Placement = Top then //Put the turret on the centre bottom of the platform
    begin
      X := Plat.X + (Plat.Width / 2) - (WIDTH / 2);
      Y := Plat.Y + Plat.Height;
    end
  else if Placement = Left then //Put the turret on the centre right of the platform
    begin
      X := Plat.X + Plat.Width + 5;
      Y := Plat.Y + (Plat.Height / 2) - (HEIGHT / 2);
    end
  else if Placement = Right then //Put the turret on the centre left of the platform
    begin
      X := Plat.X - WIDTH - 5;
      Y := Plat.Y + (Plat.Height / 2) - (HEIGHT / 2);
    end;
end;

procedure TTurret.HasBeenHit(Bullets : array of TBullet);
begin
  for var i := 0 to High(Bullets) do //iterate over all the bullets
    begin
      var BulletBounds := Bullets[i].BulletBounds(); //Gets the bullet's bounds

      //Checks the X collision
      if (BulletBounds[0][1] >= X) and (BulletBounds[0][0] <= X + WIDTH) then
        begin
          //Checks the Y collision
          if (BulletBounds[1][0] <= Y + HEIGHT) and (BulletBounds[1][1] >= Y) then
            //If both collided then it has been hit so needs to run the appropriate procedure
            BulletHit(Bullets[i]);
        end;
    end;
end;

function TTurret.ShouldShoot(player : TPlayer; Ais : array of TPlayer; FixedPlats,
                             RandPlats : array of TPlat; TargetAngle : float) : boolean;
var
  Bullet : TBullet; //This will be a test bullet to see if it hits
begin
  if (Angle - TargetAngle <= 2) and (Angle - TargetAngle >= -2) then //If the angle is 2 degrees off the target
                                                                     //angle it will run code. This makes it more efficient
                                                                     //as it is not running the code unnecessarily
    begin
      //Spawns the test bullet how the turret usually would
      if Angle >= 180 then
        Bullet := TBullet.create(true, X + WIDTH/2 - UBullet.HEIGHT - 1, Y + HEIGHT/2, 15, Angle)
      else
        Bullet := TBullet.create(false, X + WIDTH/2 - UBullet.HEIGHT - 1, Y + HEIGHT/2, 15, Angle);

      repeat //Keep running the code until it has recieved a true result, or has exited
             //with false due to it hitting the wrong thing
        begin
          Bullet.Move(); //Moved the test bullet

          for var i := 0 to High(Ais) do //Iterate over the Ai units
            begin
              if Bullet.HitPlayer(Ais[i]) then //If the bullet hit the selected Ai unit
                Exit(true); //Exit with true as it would be hitting a target of some sort
            end;
          for var i := 0 to High(FixedPlats) do //Iterate over the fixed platforms
            begin
              if Bullet.HitPlat(FixedPlats[i]) then //If the test bullet has hit the selected fixed platform
                Exit(false); //Then it hit something unwanted so exit with false
            end;
          for var i := 0 to High(RandPlats) do //Iterate over the random platforms
            begin
              if Bullet.HitPlat(RandPlats[i]) then //If the test bullet has hit the selected random platform
                Exit(false); //Then it hit something unwanted so exit with false
            end;

          if (Bullet.X > maxX) or (Bullet.Y > maxY) or (Bullet.X < 0) or (Bullet.Y < 0) then //If the test bullet goes off screen
            Exit(false);
        end
      until (Bullet.HitPlayer(player));

      Exit(true);
    end;

  Exit(false);
end;

procedure TTurret.BulletHit(Bullet : TBullet);
begin
  if Bullet.FramesLeft = 3 then //If the bullet hasnt hit anything
    begin
      dec(ShotsTillDead); //record it has hit the turret
      dec(Bullet.FramesLeft); //and make the bullet recognize it has hit something
    end;
end;

function TTurret.getTargetAngle(player : TPlayer) : float;
var
  DifferenceX, DifferenceY : float; //The difference in X and Y between the turret
                                    //and player, making it easy to use in the trigonometry
begin
  DifferenceX := (player.X + (UPlayer.PLAYERHEAD / 2)) - X;
  DifferenceY := (player.Y + (UPlayer.PLAYERHEIGHT / 2)) - Y;

  if (DifferenceX = 0) and (DifferenceY = 0) then //If the player is on the turret
    Exit(0)
  else if (DifferenceX = 0) and (DifferenceY < 0) then //If the player is above the turret
    Exit(0)
  else if (DifferenceX = 0) and (DifferenceY > 0) then //If the player is under the turret
    Exit(180)
  else if (DifferenceX > 0) and (DifferenceY = 0) then //If the player is to the right of the turret
    Exit(90)
  else if (DifferenceX < 0) and (DifferenceY = 0) then //If the player is to the left of the turret
    Exit(270)


  //The trigonmetry below works out the angle in radians, throughout the program
  //we have been using degrees so at the end of each equation we need
  // / (Pi / 180) to convert it from radians to degrees
  else if (DifferenceX > 0) and (DifferenceY < 0) then //Angles 0 to 90
    begin
      if DifferenceX >= DifferenceY * -1 then //Angles 45 to 90
        //Uses the angle from the 90 degrees line (right) so it is Y / X
        //and needs the 90 - (ANGLE) to make it correct for this quadrant (upper right)
        //The DifferenceY is negative so needs the * -1 to make it positive so it works properly
        Exit(90 - (Tanh((DifferenceY * -1) / DifferenceX) / (Pi / 180)))
      else //Angles 0 to 44
        //Uses the angle from the 0 degrees line (up) so is the X / Y
        Exit(Tanh(DifferenceX / (DifferenceY * -1)) / (Pi / 180));
    end
  else if (DifferenceX > 0) and (DifferenceY > 0) then //Angles 90 to 180
    begin
      if DifferenceX >= DifferenceY then //Angles 90 to 135
        //Uses the angle from the 90 degrees line (right) so it is Y / X
        //and needs the 90 + (ANGLE) to make it correct for this quadrant (lower right)
        Exit(90 + (Tanh(DifferenceY / DifferenceX) / (Pi / 180)))
      else //Angles 136 to 180
        //Uses the angle from the 180 degrees line (down) so it is X / Y
        //and needs to 180 - (ANGLE) to make it correct for this quadrant (lower right)
        Exit(180 - (Tanh(DifferenceX / DifferenceY) / (Pi / 180)));
    end
  else if (DifferenceX < 0) and (DifferenceY < 0) then //Angles 270 to 360
    begin
      if DifferenceX <= DifferenceY then //Angles 270 to 315
        //Uses the angle from the 270 degrees line (left) so it is Y / X
        //and needs the 270 + (ANGLE) to make it correct for the quadrant (upper left)
        //both are negative so they both need * -1 to make them positive so it works properly
        Exit(270 + (Tanh((DifferenceY * -1) / (DifferenceX * -1)) / (Pi / 180)))
      else //Angles 316 to 360
        //Uses the angle from the 360 degrees line (up) so it is X / Y
        //and needs the 360 - (ANGLE) to make it correct for the quadrant (upper left)
        //both are negative so they both need * -1 to make them positive so it works properly
        Exit(360 - (Tanh((DifferenceX * -1) / (DifferenceY * -1)) / (Pi / 180)));
    end
  else if (DifferenceX < 0) and (DifferenceY > 0) then //Angles 180 to 270
    begin
      if DifferenceX * -1 >= DifferenceY then //Angles 225 to 270
        //Uses the angle from the 270 degrees line (left) so it is Y / X
        //and needs the 270 - (ANGLE) to make it correct for the quadrant (lower left)
        //the X is negative so it needs the * -1 to make it positive so it works properly
        Exit(270 - (Tanh(DifferenceY / (DifferenceX * -1)) / (Pi / 180)))
      else //Angles 224 to 180
        //Uses the angle from the 180 degrees line (down) so it is X / Y
        //and needs the 180 + (ANGLE) to make it correct for the quadrant (lower left)
        //the X is negative so it needs the * -1 to make it positive so it works properly
        Exit(180 + (Tanh((DifferenceX * -1) / DifferenceY) / (Pi / 180)));
    end;
end;

end.
