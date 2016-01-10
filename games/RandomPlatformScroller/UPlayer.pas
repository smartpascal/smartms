unit UPlayer;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
//Knockback is a feature that, when shot, the player will
//be knocked back and is a planned feature that will work when
//an enemy is implemented.
interface

uses
  w3system, UPlat, UGlobalsNoUserTypes;

const
  MAXMOVESPEED = 5; //The maximum speed the player can move left or right
  PLAYERHEAD = UGlobalsNoUserTypes.PLAYERHEAD; //Width of the player
  PLAYERHEIGHT = UGlobalsNoUserTypes.PLAYERHEIGHT; //Height of the player
  MAXJUMPFRAMES = 15; //Max jump height
  SHOTINTERVAL = 30; //How long between each of the player's shots (min value)
  SPEEDINC = 0.5; //How much the speed will increase when it starts moving
  SPEEDDEC = 0.2; //How much the speed will decrease when it stops moving
  MAXKNOCKBACKFRAMES = 6; //The max height knockback will cause
  KNOCKBACKXCHANGE = 5; //How much the x will change every frame while knockback is active
  DAMAGE = 15; //The default amount of damage caused by the player's shots
  REGEN = 0.1; //The default amount of health regen for the player

type TPlayer = class(TObject)
  public
    //SX: the starting X, used for the respawn of the player
    //SY: the starting y, used for the respawn of the player
    //HealthRegen: is the amount of health gained each frame
    //GravSpeed: the amount added to the y when falling, gravity speed
    //Jump: the jump frame, subtracts from the y its value when active
    //Jumps: the amount of jumps that has happened in the air, allowed double jumping
    //Fall: the falling frame for if the player falls through a platform
    //i: used for iteration
    //KnockBackFrame: is the knock back's frame and subtracts from y its value
    //Damage: the damage the player's shots will cause
    //timeSinceShot: how many frames it has been before since the player has shot
    //AtGround:  if the player is Grounded, so on a platform
    //FaceLeft: if the player is facing left
    //GoingLeft: if the player is moving left
    //GoingRight: if the player is moving right
    //canShoot: if the player is able to shoot again
    //LeftDown: if the left key is held down still
    //RightDown: if the right key is held down still
    //Dead: if the player is dead
    //CanMove: if the player is able to move
    //KnockbackLeft: if the player's knockback (when active) is going left
    //CanWallJump: records if the player is on the side of a platforms, allowing it to wall jump off of it
    X, Y, SX, SY, MoveSpeed, Health, HealthRegen: float;
    GravSpeed,  Jump,  Jumps, Fall, i, KnockBackFrame, Damage, timeSinceShot : integer;
    AtGround, FaceLeft, GoingLeft, GoingRight, canShoot, LeftDown,
      RightDown, dead, canMove, KnockBackLeft, FallChangeThisFrame, CanWallJump : boolean;
    colour : string;
    constructor start(); //Starts the player, so it can be spawned using the create procedure
    //Spawns the player properly ready for a level
    procedure create(newX,newY : float; newColour : string; newHealth : integer;
                     FixedPlats, RandPlats : Array of TPlat; newDamage : integer = DAMAGE); virtual;
    procedure update(width : float; PLAYERHEALTH : integer); //Updates the co-ordinate of the player
                                                             //and changes all the other variables
    procedure FallDead(); //Makes the player fall if it is dead
    procedure updateShoot(); //updates the shoot so makes you able to shoot
    procedure resetShoot(); //resets shot based variables
    //This checks if the player is grounded so is it on a platform and will properly set it upon it
    procedure isGrounded(height : float; Fixed : array of UPlat.TPlat; Rand : array of UPlat.TPlat);
    procedure Move(Direction : MoveCommands); //Changes the players move direction
    procedure doJump(); //makes the player start to jump
    procedure doFall(); //Makes the player start to fall through platforms
    procedure CollidedLeft(Plat : TPlat); //runs code for if the player collided on the left
    procedure CollidedRight(Plat : TPlat); //runs code for if the player collided on the right
    procedure CollidedTop(Plat : TPlat); //runs code for if the player collided on the top of it
    procedure CollidedBottom(Plat : TPlat); //runs code for if the player collided on the bottom of it
    function CollideLeft(Plat : TPlat) : boolean; //checks if it hit a platform on the left of the player
    function CollideRight(Plat : TPlat) : boolean; //checks if it hit a platform on the right of the player
    function CollideTop(Plat : TPlat) : boolean; //checks if it hit a platform on the top of the player
    function CollideBottom(Plat : TPlat) : boolean; //checks if it hit a platform on the bottom of the player
    function ShootAngle(Targx, Targy : float) : float; //Gets the angle to shoot at relative to its own X and Y position,
                                                       //as well as the target's x and y position
end;

implementation

constructor TPlayer.start();
begin
  x := 0;
  y := 0;
  SX := 0;
  SY := 0;
end;

procedure TPlayer.create(newX, newY : float; newColour : string; newHealth : integer;
          FixedPlats, RandPlats : array of TPlat; newDamage : integer = DAMAGE);
begin
  X := newX;
  Y := newY;
  SX := newX;
  SY := newY;
  GravSpeed := 0;
  Jump := 0;
  GoingLeft := False;
  GoingRight := False;
  AtGround := False;
  Jumps := 2;
  Fall := 0;
  FaceLeft := False;
  colour := newColour;
  timeSinceShot := SHOTINTERVAL;
  canShoot := True;
  MoveSpeed := 0;
  canMove := True;
  dead := False;
  KnockBackFrame := -1;
  Damage := newDamage;
  Health := newHealth;
  HealthRegen := REGEN;
  CanWallJump := false;
end;

procedure TPlayer.update(width : float; PLAYERHEALTH : integer);
begin
  if (AtGround = False) and (Jumps <> 2) then //If it is not at ground, set jumps to one
                                              //so it is able to jump one more time in the air.
    begin
      Jumps := 1;
    end;
  X += MoveSpeed; //Adds the movespeed to the x so that it moves left or right
  if GoingLeft then //if it is going left then change the move speed (to a minus)
    begin
      if MoveSpeed > -MAXMOVESPEED then
        begin
          MoveSpeed -= SPEEDINC;
        end;
    end;
  if GoingRight then //if it is going right then change the move speed (to a plus)
    begin
      if MoveSpeed < MAXMOVESPEED then
        begin
          MoveSpeed += SPEEDINC;
        end;
    end;
  if (GoingLeft = False) and (GoingRight = False) then //If not moving, stop the player moving
    begin
      if MoveSpeed > 0 then
        begin
          MoveSpeed -= SPEEDDEC;
        end;
      if MoveSpeed < 0 then
        begin
          MoveSpeed += SPEEDDEC;
        end;
      if (MoveSpeed >= -1) and (MoveSpeed <= 1) then
        begin
          MoveSpeed := 0;
        end;
     end;
  if X + PLAYERHEAD >= width then //Stop the player moving if it hits the right hand side of the screen
     begin
       X := width - PLAYERHEAD - 0.25;
       GoingRight := False;
       MoveSpeed := 0;
     end;
  if X <= 0 then //Stop the player moving if it hits the left hand side of the screen
    begin
      X := 0 + 0.25;
      GoingLeft := False;
      MoveSpeed := 0;
    end;
  if Jump > 0 then //If the player's jump frame is above 0, change it and the player's Y
    begin
      Y -= Jump; //Makes the player move up by how many its jump frame is
      Jump -= 1; //Subtracts 1 from the jump frame
      GravSpeed := 0; //Sets gravity to 0
      AtGround := True; //Sets it to be at ground so gravity is off
    end;
  if KnockBackFrame > 0 then //If the knockback is active, act accordingly
    begin
      if KnockBackLeft then //If it is going left, make the player move left
        begin
          X -= KNOCKBACKXCHANGE;
        end
      else //else make the player move right
        begin
          X += KNOCKBACKXCHANGE;
        end;
      Y -= KnockBackFrame; //Subtract the knockbackframes from the player Y so it moves up
      KnockBackFrame -= 1; //Make the knockbackframe one less as another frame has passed
      GravSpeed := 0; //Sets the gravity to 0
      AtGround := True; //Sets it to grounded making it turn off the gravity
      MoveSpeed := 0; //Makes the move speed 0 so the player cannot move while knockback is active
    end;
  if KnockBackFrame = 0 then //If knockback is active but just falling at the end of it
    begin
      if KnockBackLeft then //If the knockback is going left minus the x change so it moves left
        begin
          X -= KNOCKBACKXCHANGE;
        end
      else //Else make it add the x change so it moves right
        begin
          X += KNOCKBACKXCHANGE;
        end;
      AtGround := False;
      MoveSpeed := 0; //Makes the move speed 0 so the player cannot move while knockback is active
    end;
  FallChangeThisFrame := false;
  if Fall > 0 then //If the player is falling
    begin
      Fall -= 1; //Subtract one from the fall frame so it will eventually stop falling
      AtGround := False; //Turns on gravity
      FallChangeThisFrame := true; //Records that the falling has changed this frame
    end;
  if (AtGround = False) and (Jump = 0) then //If the player is not grounded and not jumping
    begin
      Y += GravSpeed; //Adds gravity to the Y to make it fall
      if GravSpeed <= PLAYERHEIGHT - 15 then //Cap the gravity so it won't go above a certain value
        begin
          GravSpeed += 1; //If it is not at the capped limit, add one to the gravity speed
        end;
    end;
  if Health <= 0 then //If the player health is below 0, make the player dead
    begin
      Health := 0;
      dead := True;
    end
  else //Otherwise regenerate the health, as long as it is below the max health
    begin
      if Health < PLAYERHEALTH then
        begin
          Health += HealthRegen;
        end;
    end;
end;

procedure TPlayer.FallDead();
begin
  MoveSpeed := 0; //Make it unable to move left or right.
  Y += GravSpeed; //Add the gravity to the Y
  if GravSpeed <= PLAYERHEIGHT - 15 then //Adds one to the gravity if it is within
                                         //the capped limit.
    begin
      GravSpeed += 1;
    end;
end;

procedure TPlayer.updateShoot();
begin
  timeSinceShot += 1; //adds one to the time since it shot
  if timeSinceShot >= SHOTINTERVAL then //If it has been the minimum time allowed before
                                        //it can shoot again, make it able to shoot.
    begin
      canShoot := True;
    end;
end;

procedure TPlayer.resetShoot();
begin
  canShoot := False; //Makes it unable to shoot
  timeSinceShot := 0; //Records that it has just shot in the current frame
end;

procedure TPlayer.isGrounded(height : float; Fixed : array of UPlat.TPlat;
                             Rand : array of UPlat.TPlat);
begin
  CanWallJump := false; //So that you can not always wall jump even when not on a wall
  i := 0;
  while i <= High(Fixed) do //Iterate through the fixed platforms
    begin
      if (Fall = 0) or (Fixed[i].noFall) then //If the player is not falling, or you cannot fall through the platform
        begin
          if CollideLeft(Fixed[i]) then //Checks the left side collision, and act accordingly
            begin
              CollidedLeft(Fixed[i]);
              break;
            end;
        end;
      i += 1; //Selects the next platform
    end;
    i := 0;
    while i <= High(Fixed) do //Iterate through the fixed platforms
      begin
        if (Fall = 0) or (Fixed[i].noFall) then //If the player is not falling, or you cannot fall through the platform
          begin
            if CollideRight(Fixed[i]) then //Checks the right side collision, and acts accordingly
              begin
                CollidedRight(Fixed[i]);
                break;
              end;
          end;
        i += 1; //Selects the next platform
      end;
    i := 0;
    while i <= High(Rand) do //Iterate through the random platforms
      begin
        if (Fall = 0) or (Rand[i].noFall) then //If the player is not falling, or you cannot fall through the platform
          begin
            if CollideLeft(Rand[i]) then //Checks the left side collision, and acts accordingly
              begin
                CollidedLeft(Rand[i]);
                break;
              end;
          end;
        i += 1; //Selects the next platform
      end;
    i := 0;
    while i <= High(Rand) do //Iterate through the random platforms
      begin
        if (Fall = 0) or (Rand[i].noFall) then //If the player is not falling, or you cannot fall through the platform
          begin
            if CollideRight(Rand[i]) then //Checks the right side collision and acts accordingly
              begin
                CollidedRight(Rand[i]);
                break;
              end;
          end;
        i += 1; //Selects the next platform
      end;
    AtGround := False; //Sets atGround to false so that it iterates over the
                       //platforms and if it is no longer grounded, it will set it to not
                       //grounded rather than just keep this at true
    //Iterate through the fixed platforms
    i := 0;
    while (i <= High(Fixed)) do
      begin
        if CollideTop(Fixed[i]) then //Checks the top side collision, and acts accordingly
          begin
            CollidedTop(Fixed[i]);
            break;
          end;
        i += 1; //Selects the next platform
      end;
    i := 0;
    while (i <= High(Rand)) do //Iterate through the random platforms
      begin
        if CollideTop(Rand[i]) then //Checks the top side collision, and act accordingly
          begin
            CollidedTop(Rand[i]);
            break;
          end;
        i += 1; //Selects the next platform
      end;
    i := 0;
    //Iterate through the fixed platforms while the player is not AtGround
    while (AtGround = False) and (i <= High(Fixed)) do
      begin
        if CollideBottom(Fixed[i]) then //Checks the bottom collision, and acts accordingly
          begin
            if (Fall = 0) or (Fixed[i].noFall) then //If the player is not falling, or you cannot fall through the platform
              begin
                Fall := 0;
                CollidedBottom(Fixed[i]);
                break;
              end
            //Keeps us falling if were still in a vertical platform
            else if (FallChangeThisFrame = true) and (Fall <= 2) and (Fixed[i].horizontal = false) then
              begin
                Fall := 2;
                break;
              end;
          end;
        i += 1; //Selects the next platform
      end;
    i := 0;
    //Iterate through the random platforms while the player is not AtGround
    while (AtGround = False) and (i <= High(Rand)) do
      begin
        if CollideBottom(Rand[i]) then //Checks the bottom collision and acts accordingly
          begin
            if (Fall = 0) or (Rand[i].noFall) then //If the player is not falling, or you cannot fall through the platform
              begin
                Fall := 0;
                CollidedBottom(Rand[i]);
                break;
              end
            //Keeps us falling if were still in a vertical platform
            else if (FallChangeThisFrame = true) and (Fall <= 2) and (Rand[i].horizontal = false) then
              begin
                Fall := 2;
                break;
              end;
          end;
        i += 1; //Selects the next platform
      end;
    if Y <= -1 then //If the Y is less than 0
      begin
        Jump := 0; //Stop it increasing height and ready to fall
        Y := 0; //Sets the Y to 0, being the minimum
        GravSpeed := 0; //Sets the gravity to 0
      end;
  if (Y >= height) and (Dead = False) then //If the Y is lower than the
                                           //maximum y and it is not already dead
    begin
      dead := True; //Sets the player to dead
    end;
end;

procedure TPlayer.Move(Direction : MoveCommands);
begin
  if Direction = MoveCommands.right then //If it was instructed to move right, make it move right.
    begin
      GoingLeft := False;
      GoingRight := True;
      FaceLeft := False;
    end
  else if Direction = MoveCommands.left then //If it was instructed to move left, make it move left.
    begin
      GoingLeft := True;
      GoingRight := False;
      FaceLeft := True;
    end
  else if Direction = MoveCommands.null then //If it was instructed to stop moving, stop it moving.
    begin
      GoingLeft := False;
      GoingRight := False;
    end;
end;

procedure TPlayer.doJump();
begin
  if (Jumps < 2) and (Jump <= 7) and (Fall = 0) then //If you have done less than 2 jumps already and
                                                     //the player's jump frame is less than 7 (to
                                                     //stop a massive jump at the start)
    begin
      Fall := 0;
      Jumps += 1; //Increase the amount of jumps done
      Jump := MAXJUMPFRAMES; //Sets the frames for the jump to the maximum
    end;
  if (CanWallJump) and (Fall = 0) then //Jumps off the wall if the player can
    begin
      Fall := 0;
      Jumps := 1; //Sets it to one, so that the player can do another jump in the
                  //air after jumping off the wall
      Jump := MAXJUMPFRAMES; //Sets the frames for the jump to the maximum
      if MoveSpeed = 0 then
        begin
          if FaceLeft then
            MoveSpeed := MAXMOVESPEED
          else
            MoveSpeed := -MAXMOVESPEED;
        end
      else if MoveSpeed < 0 then
        MoveSpeed := MAXMOVESPEED
      else
        MoveSpeed := -MAXMOVESPEED;
    end;
end;

procedure TPlayer.doFall();
begin
  if (Fall = 0) and (AtGround = True) then //If the fall is inactive and you are on a platform
    begin
      Fall := 15; //Fall frames set to 15
      GravSpeed := 0;
    end;
end;

procedure TPlayer.CollidedLeft(Plat : TPlat);
begin
  if MoveSpeed < 0.2 then
    begin
      MoveSpeed := -0.1; //So you do not shoot off after getting out the way of the platform and so you do not stick to the platform
      X := Plat.X + Plat.Width + 0.1; //Sets the x to the right hand side of the platform
    end;
  if Plat.NoWallJump = false then
    CanWallJump := true; //Allows the player to jump off the wall if the platform is not a no wall jump platform
  if KnockBackFrame <> -1 then //Stop knockback so you can move again and so you dont move through the platform
    begin
      Jump := KnockBackFrame;
      KnockBackFrame := -1;
    end;
end;

procedure TPlayer.CollidedRight(Plat : TPlat);
begin
  if MoveSpeed > -0.2 then
    begin
      MoveSpeed := 0.1; //So you do not shoot off after getting out the way of the platform and so you do not stick to the platform
      X := Plat.X - PLAYERHEAD - 0.1; //Puts the X to the left of the platform
    end;
  if Plat.NoWallJump = false then
     CanWallJump := true; //Allows the player to jump off the wall if the platform is not a no wall jump platform
  if KnockBackFrame <> -1 then //Stop knockback so you can move again and so you don't move through the platform
    begin
      Jump := KnockBackFrame;
      KnockBackFrame := -1;
    end;
end;

procedure TPlayer.CollidedTop(Plat : TPlat);
begin
  Jump := 0; //Sets the jump frame to 0, meaning it is going to start falling again
  if KnockBackFrame <> -1 then //If the knockback is not inactive
    begin
      KnockBackFrame := 0; //Sets the knockback to active, but falling
    end;
  Y := Plat.Y + Plat.Height + 0.25; //Puts the player Y to under the platform
  GravSpeed := 0; //Sets the gravity to 0, and it will fall
end;

procedure TPlayer.CollidedBottom(Plat : TPlat);
begin
  Y := Plat.Y - PLAYERHEIGHT; //Sets the Y on top of the platform
  AtGround := True; //Sets it to be AtGround
  Jumps := 0; //Makes you able to (double) jump again
  GravSpeed := 0; //Sets the gravity to 0 so it does not fall any more
  KnockBackFrame := -1; //Makes the player knockback inactive (for if it was active)
  if Plat.Crumble then
    begin
      Plat.Crumbling := true; //if the plat is a crumble one, it will activate the crumble sequence
    end;
end;

function TPlayer.CollideLeft(Plat : TPlat) : boolean;
var
  //If this is false, it won't bother checking the Y collision as it has already
  //failed the X collision, so has not collided. This makes it more efficient.
  stillCheck : boolean;
begin
  stillCheck := false;

  //Checks if the left hand side overlaps the right hand side of the platform
  if (X <= Plat.X + Plat.Width) and (X >= Plat.X + Plat.Width - MAXMOVESPEED - 1) then
    begin
      stillCheck := true; //If it overlapped, still check the y axis overlap
    end;

  if stillCheck then //Checks for a Y overlap
    begin
      //If the bottom of the player is overlapping the y range of the platform
      if (Y + PLAYERHEIGHT > Plat.Y) and (Y + PLAYERHEIGHT < Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeeded, it passed both so it returns true
        end
      //If the top of the player is overlapping the y range of the platform
      else if (Y > Plat.Y) and (Y < Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeeded, it passed both so it returns true
        end
      //If the top of the player if higher than the top of the platform
      //and the bottom of the player is lower than the bottom of the platform
      else if (Y < Plat.Y) and (Y + PLAYERHEIGHT > Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeeded, it passed both so it returns true
        end;
    end;

  Exit(false); //At least one of the two failed, so it did not collide
end;

function TPlayer.CollideRight(Plat : TPlat) : boolean;
var
  //If this is false, it wont bother checking the Y collision as it has already
  //failed the X collision, so has not collided. This makes it more efficient.
  stillCheck : boolean;
begin
  stillCheck := false;

  //Checks if the right hand side of the player overlaps the left side of the platform
  if (X + PLAYERHEAD >= Plat.X) and (X + PLAYERHEAD <= Plat.X + MAXMOVESPEED + 1) then
    begin
      stillCheck := true; //If it overlapped, still check the y axis overlap
    end;

  if stillCheck then //Checks for a Y overlap
    begin
      //If the bottom of the player is overlapping the y range of the platform
      if (Y + PLAYERHEIGHT > Plat.Y) and (Y + PLAYERHEIGHT < Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeed, it passed both so it returns true
        end
      //If the top of the player is overlapping the y range of the platform
      else if (Y > Plat.Y) and (Y < Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeed, it passed both so it returns true
        end
      //If the top of the player if higher than the top of the platform
      //and the bottom of the player is lower than the bottom of the platform
      else if (Y < Plat.Y) and (Y + PLAYERHEIGHT > Plat.Y + Plat.HEIGHT) then
        begin
          Exit(true); //If it succeeded, it passed both so it returns true
        end;
    end;

  Exit(false); //At least one of the two failed, so it did not collide.
end;

function TPlayer.CollideTop(Plat : TPlat) : boolean;
var
  //If this is false, it won't bother checking the Y collision as it has already
  //failed the X collision, so has not collided. This makes it more efficient.
  stillCheck : boolean;
begin
  stillCheck := false;

  if (Jump <> 0) //if the player's jump is not active, it is not
                 //moving up so won't hit the top
  and (Plat.jumpThrough = false) //This is as if it can jump through it, it
                                 //should not bother checking
  and (Y + PLAYERHEIGHT > Plat.Y + Plat.HEIGHT) then //This is so that it knows the player
                                                     //is underneath the platform
    begin
      //Checks if the x range of the player is inside the x range of the platform
      if (X < Plat.X + Plat.Width) and (X + PLAYERHEAD > Plat.X) then
        begin
          stillCheck := true; //if it was true, it will still check the y collision
        end;

      if stillCheck then //Run the y collision if it is worth checking still
        begin
          //Checks if the y range is inside the platforms's Y range
          if (Y <= Plat.Y + Plat.Height) and (Y + PLAYERHEIGHT >= Plat.Y) then
            begin
              Exit(true); //If this was true, both were true so its hit
            end;
        end;
    end;

  Exit(False); //It is not moving up or can jump through the platform
               //or did not collide both, so returns false
end;

function TPlayer.CollideBottom(Plat : TPlat) : boolean;
var
  //if this is false, it will not bother checking the Y collision as it has already
  //failed the X collision, so has not collided. This makes it more efficient
  stillCheck : boolean;
begin
  stillCheck := false;

  if (Jump = 0) then //if the player's Jump is active, it is not
                     //moving down so will not land on a platform
    begin
      //Checks if the x range of the player is inside the x range of the platform
      if (X < Plat.X + Plat.Width) and (X + PLAYERHEAD > Plat.X) then
        begin
          stillCheck := true; //if it was true, it will still check the y collision
        end;

      if stillCheck then //Run the y collision if it is worth checking still
        begin
          if GravSpeed < Plat.Height then //Doing two different ways if the gravspeed
                                          //is less than the height of the platform is
                                          //for graphical purposes as it looks
                                          //strange doing it the normal way of
                                          //checking the whole range of the player's
                                          //Y as opposed to just checking if the bottom
                                          //is inside the platform's y range
            begin
              //Checks if the bottom y is inside the platform's Y range
              if (Y + PLAYERHEIGHT <= Plat.Y + Plat.Height) and (Y + PLAYERHEIGHT >= Plat.Y) then
                begin
                  Exit(true); //If this was true, both were true so it has hit
                end;
            end
          else
            begin
              //Checks if the y range is inside the platforms's Y range
              if (Y <= Plat.Y + Plat.Height) and (Y + PLAYERHEIGHT >= Plat.Y) then
                begin
                  Exit(true); //If this was true, both were true so it has hit
                end;
            end;

        end;
    end;

  Exit(False); //It is not moving up or can jump through the platform
               //or did not collide both, so returns false
end;

function TPlayer.ShootAngle(Targx, Targy : float) : float;
var
  DifferenceX, DifferenceY : float; //The difference in X and Y between the turret
                                    //and player, making it easy to use in the trigonometry
  Angle : float; //The angle that will be returned
begin
	DifferenceX := Targx - X;
	DifferenceY := Targy - Y;

	if (DifferenceX = 0) and (DifferenceY = 0) then //If the player is on the turret
	  Angle := 0
	else if (DifferenceX = 0) and (DifferenceY < 0) then //If the player is above the turret
	  Angle := 0
	else if (DifferenceX = 0) and (DifferenceY > 0) then //If the player is under the turret
	  Angle := 180
	else if (DifferenceX > 0) and (DifferenceY = 0) then //If the player is to the right of the turret
	  Angle := 90
	else if (DifferenceX < 0) and (DifferenceY = 0) then //If the player is to the left of the turret
    Angle := 270


  //The trigonmetry below works out the angle in radians, throughout the program
  //we have been using degrees so at the end of each equation we need
  // / (Pi / 180) to convert it from radians to degrees
	else if (DifferenceX > 0) and (DifferenceY < 0) then //Angles 0 to 90
    begin
      if DifferenceX >= DifferenceY * -1 then //Angles 45 to 90
        //Uses the angle from the 90 degrees line (right) so it is Y / X
        //and needs the 90 - (ANGLE) to make it correct for this quadrant (upper right)
        //The DifferenceY is negative so needs the * -1 to make it positive so it works properly
        Angle := 90 - (Tanh((DifferenceY * -1) / DifferenceX) / (Pi / 180))
      else //Angles 0 to 44
        //Uses the angle from the 0 degrees line (up) so is the X / Y
        Angle := Tanh(DifferenceX / (DifferenceY * -1)) / (Pi / 180);
    end
	else if (DifferenceX > 0) and (DifferenceY > 0) then //Angles 90 to 180
    begin
      if DifferenceX >= DifferenceY then //Angles 90 to 135
        //Uses the angle from the 90 degrees line (right) so it is Y / X
        //and needs the 90 + (ANGLE) to make it correct for this quadrant (lower right)
        Angle := 90 + (Tanh(DifferenceY / DifferenceX) / (Pi / 180))
      else //Angles 136 to 180
        //Uses the angle from the 180 degrees line (down) so it is X / Y
        //and needs to 180 - (ANGLE) to make it correct for this quadrant (lower right)
        Angle := 180 - (Tanh(DifferenceX / DifferenceY) / (Pi / 180));
    end
	else if (DifferenceX < 0) and (DifferenceY < 0) then //Angles 270 to 360
    begin
      if DifferenceX <= DifferenceY then //Angles 270 to 315
        //Uses the angle from the 270 degrees line (left) so it is Y / X
        //and needs the 270 + (ANGLE) to make it correct for the quadrant (upper left)
        //both are negative so they both need * -1 to make them positive so it works properly
        Angle := 270 + (Tanh((DifferenceY * -1) / (DifferenceX * -1)) / (Pi / 180))
      else //Angles 316 to 360
        //Uses the angle from the 360 degrees line (up) so it is X / Y
        //and needs the 360 - (ANGLE) to make it correct for the quadrant (upper left)
        //both are negative so they both need * -1 to make them positive so it works properly
        Angle := 360 - (Tanh((DifferenceX * -1) / (DifferenceY * -1)) / (Pi / 180));
    end
	else if (DifferenceX < 0) and (DifferenceY > 0) then //Angles 180 to 270
   begin
     if DifferenceX * -1 >= DifferenceY then //Angles 225 to 270
       //Uses the angle from the 270 degrees line (left) so it is Y / X
       //and needs the 270 - (ANGLE) to make it correct for the quadrant (lower left)
       //the X is negative so it needs the * -1 to make it positive so it works properly
       Angle := 270 - (Tanh(DifferenceY / (DifferenceX * -1)) / (Pi / 180))
     else //Angles 224 to 180
       //Uses the angle from the 180 degrees line (down) so it is X / Y
       //and needs the 180 + (ANGLE) to make it correct for the quadrant (lower left)
       //the X is negative so it needs the * -1 to make it positive so it works properly
       Angle := 180 + (Tanh((DifferenceX * -1) / DifferenceY) / (Pi / 180));
   end;

   if FaceLeft then //Make it only be able to shoot to the left
     begin
       if (Angle < 200) and (Angle >= 90) then
         Angle := 200
       else if ((Angle < 90) and (Angle >= 0)) or (Angle > 340) then
         Angle := 340;
     end
   else //Make it only be able to shoot to the right
     begin
       if ((Angle < 360) and (Angle >= 270)) or (Angle < 20) then
         Angle := 20
       else if (Angle < 270) and (Angle > 160) then
         Angle := 160;
     end;

  Exit(Angle); //Return the angle for the bullet
end;

end.
