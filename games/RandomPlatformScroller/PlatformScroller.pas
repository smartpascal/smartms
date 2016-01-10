unit PlatformScroller;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System, W3Components, W3Application, W3Game, W3GameApp, W3Graphics, W3Touch, UGlobals,
  UGlobalsNoUserTypes, UPlayer, UE, UPlat, UBullet, ULevelSelector, UGameText, UAi,
  UTurret, UCreates, UOptionsButton, KeyCodeToKeyName, UDrawing, lvl1, lvl2, lvl3, lvl4, lvl5, lvl6,
  lvl7, lvl8, lvl9, lvl10, lvl11, lvl12, lvl13, lvl14, lvl15, lvl16, lvl17;

type
  TApplication = class(TW3CustomGameApplication)
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure KeyDownEvent(mCode : integer);
    procedure KeyUpEvent(mCode : integer);
  end;

procedure SwapKeys(mCode : integer);
procedure LevelStarter(level : integer);
procedure PostionMoveButtons(GameWidth, GameHeight : float);

var
  i : integer; //Used for iteration

implementation
var
  LeftKeyChange : boolean;
  RightKeyChange : boolean;
  JumpKeyChange : boolean;
  FallKeyChange : boolean;
  ShootKeyChange : boolean;
  EnterKeyChange : boolean;
  EscapeKeyChange : boolean;
  Changed : integer;

{ TApplication}
procedure TApplication.ApplicationStarting;
begin
  inherited;
  Player := UPlayer.TPlayer.start(); //Starts the player
  Player.create(10, 10, 'red', PLAYERHEALTH, FPlats, RandPlats);
  i := 0;
  while i < AIS do //Starts the correct amount of Ai units
    begin
      Ai[i] := UAi.TAi.start();
      Ai[i].create(10, 10, 'blue', AIHEALTH, FPlats, RandPlats);
      i += 1;
    end;
  i := 0;
  Level := 0; //The level is 0 as it is the level selector
  gamemode := levelselector; //sets the gamemode to the selector
  selector := ULevelSelector.TSelect.create(); //starts the selector
  Options[0] := TOptionsButton.create(10, 10, 200, 65, "Change Escape Key", 15, 60);
  Options[1] := TOptionsButton.create(430, 10, 200, 65, "Change Enter Key", 435, 60);
  Options[2] := TOptionsButton.create(10, 200, 200, 65, "Change Left Key", 15, 250);
  Options[3] := TOptionsButton.create(220, 125, 200, 65, "Change Jump Key", 225, 175);
  Options[4] := TOptionsButton.create(220, 200, 200, 65, "Change Fall Key", 225, 250);
  Options[5] := TOptionsButton.create(430, 200, 200, 65, "Change Right Key", 435, 250);
  Options[6] := TOptionsButton.create(430, 125, 200, 65, "Change Shoot Key", 435, 175);
  Options[7] := TOptionsButton.create(220, 350, 200, 65, "Return to Game", 225, 400);
  Options[8] := TOptionsButton.create(10, 10, 60, 30, "Options", 15, 33);
  Options[9] := TOptionsButton.create(80, 10, 60, 30, "Restart", 85, 33);
  Options[10] := TOptionsButton.create(150, 10, 80, 30, "Level Selector", 155, 33);
  //The Controls buttons will be changed so the original values put in do not matter
  ControlButtons[0] := TOptionsButton.create(0, 0, 50, 30, "Move Left", 0 , 0);
  ControlButtons[1] := TOptionsButton.create(0, 0, 50, 30, "Move Right", 0 , 0);
  ControlButtons[2] := TOptionsButton.create(0, 0, 50, 30, "Jump", 0 , 0);
  ControlButtons[3] := TOptionsButton.create(0, 0, 50, 30, "Fall", 0 , 0);
  ControlButtons[4] := TOptionsButton.create(0, 0, 50, 30, "Shoot", 0 , 0);
  ControlButtons[5] := TOptionsButton.create(0, 0, 50, 30, "Enter Door", 0 , 0);
  Controls[0] := TText.Create('Jump: ' + CodeToKeyName(JumpKey), 'blue', 700, 50);
  Controls[1] := TText.Create('Fall: ' + CodeToKeyName(FallKey), 'blue', 700, 100);
  Controls[2] := TText.Create('Left: ' + CodeToKeyName(LeftKey), 'blue', 700, 150);
  Controls[3] := TText.Create('Right: ' + CodeToKeyName(RightKey), 'blue', 700, 200);
  Controls[4] := TText.Create('Shoot: ' + CodeToKeyName(ShootKey), 'blue', 700, 250);
  Controls[5] := TText.Create('Enter/Use: ' + CodeToKeyName(EnterKey), 'blue', 700, 300);
  Controls[6] := TText.Create('Escape: ' + CodeToKeyName(EscapeKey), 'blue', 700, 350);
  EscapeKey := 27;
  EnterKey := 32;
  RightKey := 68;
  JumpKey := 87;
  FallKey := 83;
  LeftKey := 65;
  ShootKey := 69;
  UnlockedDoors := 1;
  //UnlockedDoors := MaxInt(); //Added by PPS for the testing version

  asm //Sets up the "KeyDownEvent"
    window.onkeydown=function(e)
    {
      TApplication.KeyDownEvent(Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  asm //Sets up the "KeyUpEvent"
    window.onkeyup=function(e)
    {
      TApplication.KeyUpEvent(Self,e.keyCode);
    }
  end;
  KeyUpEvent(0);

  GameView.Delay := 20;
  GameView.StartSession(True);
end;

procedure TApplication.KeyDownEvent(mCode : integer);
begin
  if gamemode = settings then //To change settings
    begin
      SwapKeys(mCode);
    end
  else
    begin
      case mCode of
        EscapeKey : begin
                      gamemode := levelselector;
                      Player.create(10, 10, 'red', PLAYERHEALTH, FPlats, RandPlats);
                      offsetX := 0;
                      offsetY := 0;
                      maxX := 0;
                      maxY := 0;
                      Level := 0;
                    end;
        EnterKey : begin
                     if gamemode = levelselector then
                       begin
                         ClearVars();
                         LevelStarter(selector.selected(Player.X,Player.Y,Player.X + UPlayer.PLAYERHEAD,
                                           UPlayer.PLAYERHEIGHT)); //Checks the door picked
                                                                   //in the level selector
                                                                   //and changes the level accordingly
                       end;
                     if gamemode = maingame then
                       begin
                         if ExitDoor.isDone(Player.X, Player.X + PLAYERHEAD, Player.Y + PLAYERHEIGHT) then //Checks if the player is //by the exit door
                           begin
                             if Level <= 17 then
   			       begin
 				 if (UnlockedDoors <= Level) then //Makes the unlocked Door equal to the next level (about to load) if its less than or equal to the current level
				   UnlockedDoors := Level + 1;
                                 LevelStarter(Level + 1)
			       end
                             else
                               KeyDownEvent(EscapeKey);
                           end;
                       end;
                   end;
        RightKey : begin
                     if Player.Dead = False then //If the player is not dead, move it right
                       Player.Move(MoveCommands.right);
                       Player.X += 1;
                 end;
        LeftKey : begin
                    if Player.Dead = False then //If the player is not dead, move it left
                      Player.Move(MoveCommands.left);
                      Player.X -= 1;
                 end;
        JumpKey : //run the player jump if if it is alive and not suffering from knockback
                  if (Player.KnockBackFrame = -1) and (Player.Dead = False) then
                    Player.doJump();
        FallKey : if Player.Dead = False then //Make the player drop
                    Player.doFall();
        ShootKey : begin
                     //Makes the player shoot, if it is in a level, can shoot and is not dead
                     if (gamemode = maingame) and (Player.canShoot = True) and (Player.Dead = False) then
                       begin
                         i := -1;
                         repeat //Finds the first free bullet
                           i += 1;
                         until (Bullets[i].Shot = False) or (i = High(Bullets));
                         if i = High(Bullets) then //If it did not find one, make it make a new one
                           i += 1;

                         if Player.FaceLeft = True then
                           //Spawn the bullet
                           Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X - UBullet.WIDTH - 1,
                                                               Player.Y + UPlayer.PLAYERHEAD + 3, Player.Damage, 270)
                         else
                           //Spawn the bullet
                           Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X +
                                                            UPlayer.PLAYERHEAD + 1, Player.Y +
                                                            UPlayer.PLAYERHEAD + 3, Player.Damage, 90);
                         Player.resetShoot(); //reset the player's shoot variables
                       end;
                   end;
      end;
    end;
end;

procedure TApplication.KeyUpEvent(mCode : integer);
begin
  case mCode of
    RightKey : begin  //d
                 Player.Move(MoveCommands.null); //Stops the player moving on the key up
               end;
    LeftKey : begin  //a
                Player.Move(MoveCommands.null); //Stops the player moving on the key up
              end;
  end;
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  screenWidth := GameView.Width; //sets the screen width so the draw unit can know this data
  screenHeight := GameView.Height; //sets the screen height so the draw unit can know this data
  if Changed <> 0 then
    dec(Changed);

  //To be run on GameView.OnMouseDown
  procedure MouseDown(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer);
    begin
      if ControlButtons[0].clicked(x, y) then //If the left button is pressed, move left
        begin
          KeyDownEvent(LeftKey);
        end
      else if ControlButtons[1].clicked(x, y) then //If the right button was pressed, move right
        begin
          KeyDownEvent(RightKey);
        end
      else if ControlButtons[2].clicked(x, y) then //If the jump button was pressed, jump
        begin
          KeyDownEvent(JumpKey);
        end
      else if ControlButtons[3].clicked(x, y) then //If the fall button was pressed, fall
        begin
          KeyDownEvent(FallKey);
        end
      else if ControlButtons[4].clicked(x, y) then //If the shoot button was pressed, shoot
        begin
          KeyDownEvent(ShootKey);
        end
      else if ControlButtons[5].clicked(x, y) then //If the enter door button was pressed, enter the door
        begin
          KeyDownEvent(EnterKey);
        end
      else if Options[8].clicked(x, y) then
        begin
          gamemode := settings;
        end
      else if Options[9].clicked(x, y) then
        begin
          LevelStarter(Level);
        end
      else if Options[10].clicked(x, y) then
        begin
          KeyDownEvent(EscapeKey);
        end
      else if GameMode = mainGame then
        begin
          //Make the player shoot toward the mouse
          if Player.canShoot then
            begin
              i := -1;
              repeat //Finds the first free bullet
                i += 1;
              until (Bullets[i].Shot = False) or (i = High(Bullets));
              if i = High(Bullets) then //If it did not find one, make it make a new one
                i += 1;

              if Player.FaceLeft = True then
                //Spawn the bullet
                Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X - UBullet.WIDTH - 1,
                                                     Player.Y + UPlayer.PLAYERHEAD + 3, Player.Damage,
                                                     Player.ShootAngle(x + offsetX, y + offsetY))
              else
                //Spawn the bullet
                Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X +
                                                     UPlayer.PLAYERHEAD + 1, Player.Y +
                                                     UPlayer.PLAYERHEAD + 3, Player.Damage,
                                                     Player.ShootAngle(x + offsetX, y + offsetY));
              Player.resetShoot(); //reset the player's shoot variables
            end;
        end;
    end;

    //To be run on GameView.OnTouchDown
    procedure Touch(o : TObject; d : TW3TouchData); //If the screen is touched (mobile)
      begin
        KeyUpEvent(LeftKey);
        KeyUpEvent(RightKey);
        for var j := 0 to High(d.Touches.Count) do //For every finger
          begin
            var x := d.Touches.Touches[j].PageX;
            var y := d.Touches.Touches[j].PageY;

            //Code for what the touch is going
            if ControlButtons[0].clicked(x, y) then //If the left button is pressed, move left
              begin
                KeyDownEvent(LeftKey);
              end
            else if ControlButtons[1].clicked(x, y) then //If the right button was pressed, move right
              begin
                KeyDownEvent(RightKey);
              end
            else if ControlButtons[2].clicked(x, y) then //If the jump button was pressed, jump
              begin
                KeyDownEvent(JumpKey);
              end
            else if ControlButtons[3].clicked(x, y) then //If the fall button was pressed, fall
              begin
                KeyDownEvent(FallKey);
              end
            else if ControlButtons[4].clicked(x, y) then //If the shoot button was pressed, shoot
              begin
                KeyDownEvent(ShootKey);
              end
            else if ControlButtons[5].clicked(x, y) then //If the enter door button was pressed, enter the door
              begin
                KeyDownEvent(EnterKey);
              end
            else if Options[8].clicked(x, y) then
              begin
                gamemode := settings;
              end
            else if Options[9].clicked(x, y) then
              begin
                LevelStarter(Level);
              end
            else if Options[10].clicked(x, y) then
              begin
                KeyDownEvent(EscapeKey);
              end
            else if Options[8].clicked(x, y) then
              begin
                 gamemode := settings;
              end
            else if GameMode = mainGame then
              begin
                //Make the player shoot toward the mouse
                if Player.canShoot then
                  begin
                    i := -1;
                    repeat //Finds the first free bullet
                      i += 1;
                    until (Bullets[i].Shot = False) or (i = High(Bullets));
                    if i = High(Bullets) then //If it did not find one, make it make a new one
                      i += 1;

                    if Player.FaceLeft = True then
                      //Spawn the bullet
                      Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X - UBullet.WIDTH - 1,
                                                           Player.Y + UPlayer.PLAYERHEAD + 3, Player.Damage,
                                                           Player.ShootAngle(x + offsetX, y + offsetY))
                    else
                      //Spawn the bullet
                      Bullets[i] := UBullet.TBullet.create(Player.FaceLeft, Player.X +
                                                           UPlayer.PLAYERHEAD + 1, Player.Y +
                                                           UPlayer.PLAYERHEAD + 3, Player.Damage,
                                                           Player.ShootAngle(x + offsetX, y + offsetY));
                    Player.resetShoot(); //reset the player's shoot variables
                  end;
              end;
        end;
    end;

  procedure SideScroll(Player : Uplayer.TPlayer; FPlats, RandPlats : array of UPlat.TPlat;
                       maxX, maxY : integer; Ai : array of TAi); //this also handles updating of player
                                                                 //and AI
  begin
    if (GameView.Width <= maxX) then //Update the player with maxX if it is bigger than the screen
                                     //and run the sidescrolling code
      begin
        if Player.Dead then
          begin
            Player.FallDead();
          end
        else
          begin
            Player.update(maxX, PLAYERHEALTH);
            Player.updateShoot();
          end;
        i := 0;
        while i < AIS do
          begin
            if Ai[i].Dead then
              begin
                Ai[i].FallDead();
              end
            else
              begin
                //Ai[i].WorkOutMoves(Player, Bullets, FPlats, RandPlats, GameView.Width, GameView.Height);
              end;
            i += 1;
          end;
        //If the player is over halfway over the screen, make it sidescroll
        if Player.X - offsetX > GameView.Width / 2 then
          begin
            offsetX := Player.X - (GameView.Width / 2); //The x offset is equal to
                                                        //the player x minus half the gameview.width
            //If the  x offset is greater than the maxX it will stop scrolling
            if offsetX + GameView.Width > maxX then
              begin
                offsetX := maxX - GameView.Width;
              end;
          end;
        //If the player is in the first fifth of the screen, scroll left
        if Player.X - offsetX < (GameView.Width / 10) * 2 then
          begin
            offsetX := Player.X - ((GameView.Width / 10) * 2);
            if offsetX < 0 then //Stop scrolling if x offset is under 0
              begin
                offsetX := 0;
              end;
          end;
      end
    else //Else run the player with the GameView.Width with no sidescrolling
      begin
        if Player.Dead then
          begin
            Player.FallDead();
          end
        else
          begin
            Player.update(GameView.Width, PLAYERHEALTH);
            Player.updateShoot();
          end;
          i := 0;
          while i < AIS do
            begin
              if Ai[i].Dead then
                begin
                  Ai[i].FallDead();
                end
              else
                begin
                  //Ai[i].WorkOutMoves(Player, Bullets, FPlats, RandPlats, GameView.Width, GameView.Height);
                end;
              i += 1;
            end;
      end;
    if GameView.Height <= maxY then //Update with the maxY if it is bigger than the gameview height
      begin
        if Player.Dead = False then
          begin
            Player.isGrounded(maxY,FPlats,RandPlats); //checks the grounding of the platforms for the player
          end;
        //If the bottom of the player is in the second half of the screen, scroll down
        if Player.Y + UPlayer.PLAYERHEIGHT - offsetY > GameView.Height / 2 then
          begin
            offsetY := Player.Y + UPlayer.PLAYERHEIGHT - (GameView.Height / 2);
            //Stop scrolling if the offset is over the maxY
            if offsetY + GameView.Height > maxY then
              begin
                offsetY := maxY - GameView.Height;
              end;
          end;
        //If the bottom of the player is in the top fifth of the screen, scroll up
        if Player.Y - offsetY < (GameView.Height / 10) * 2 then
          begin
            offsetY := Player.Y - ((GameView.Height / 10) * 2);
            //Stop scrolling if it is under 0 offset
            if offsetY < 0 then
              begin
                offsetY := 0;
              end;
           end;
      end
    else //Else no vertical scrolling and updates with GameView.Height
      begin
        if Player.Dead = False then
          begin
            Player.isGrounded(GameView.Height, FPlats, RandPlats);
          end;
      end;
  end;

  if gamemode = levelselector then //run the updates and drawing needed for the selector
    begin
      SideScroll(Player, Selector.Plats, Selector.Plats, selector.maxX,
                 selector.maxY, selector.Ai);
      // Clear background
      Canvas.FillStyle := 'white';
      Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
      // Draw our framerate on the screen
      Canvas.Font := '10pt verdana';
      Canvas.FillStyle := 'red';
      Canvas.FillTextF('FPS: ' + IntToStr(GameView.FrameRate), 80, 20, MAX_INT);

      DrawButton(Options[8], 20, Canvas); //Draw the button to go to settings

      PostionMoveButtons(GameView.Width, GameView.Height); //Position the controls buttons
      for var i := 0 to High(ControlButtons) do //Draw all the controls button
        begin
          DrawControlButton(ControlButtons[i], 15, Canvas);
        end;

      //If mouse is clicked run code depending on where it is
      GameView.OnMouseDown := MouseDown;

      //Touch code run when the touches change
      GameView.OnTouchBegin := Touch;

      GameView.OnTouchMove := Touch;

      GameView.OnTouchEnd := Touch;

      //If the click is released, stop the player moving
      GameView.OnMouseUp := procedure(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer)
        begin
          KeyUpEvent(LeftKey);
          KeyUpEvent(RightKey);
        end;

      //Update the text on the selector so that it will display the correct key if it is updated
      Selector.Text[0].text := 'Use ' + CodeToKeyName(EnterKey) + ' to go through the door';
      Selector.Text[1].text := 'Use ' + CodeToKeyName(LeftKey) + ' and ' + CodeToKeyName(RightKey) + ' to move left and right';

      DrawPlats(Selector.Plats,Canvas);     //Platforms
      DrawDoors(Selector.Doors,Canvas);     //Doors
      DrawText(Selector.Text,Canvas);       //Text
      DrawPlayer(Player,Canvas);            //Player

      if Player.Y - offsetY > GameView.Height then //If the player goes off screen, restart the selector
        begin
          KeyDownEvent(EscapeKey);
        end;
    end;

  if gamemode = maingame then //Runs the needed updates and drawings for the levels
    begin
      SideScroll(Player, FPlats, RandPlats, maxX, maxY, Ai); //Player and Ai update code is run here
                                                             //so do not need to call it anywhere else
      i := 0;
      while i <= High(Bullets) do //Iterates through the bullets
        begin
          if GameView.Width > maxX then //Updates bullets with larger one from maxX and Gameview.Width
            begin
              Bullets[i].update(GameView.Width, Player, Ai, FPlats, RandPlats);
            end
          else
            begin
              Bullets[i].update(maxX, Player, Ai, FPlats, RandPlats);
            end;
          i += 1;
        end;

      for var i := 0 to High(Turrets) do //Update the turrets
        begin
          Turrets[i].Update(player, Bullets, Ai, FPlats, RandPlats);
        end;

      // Clear background
      Canvas.FillStyle := 'white';
      Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
      // Draw our framerate on the screen
      Canvas.Font := '10pt verdana';
      Canvas.FillStyle := 'red';
      Canvas.FillTextF('FPS: ' + intToStr(GameView.FrameRate), 240, 20, MAX_INT);

      //Draws Stuff
      DrawDoor(EntranceDoor,Canvas);      //EntranceDoor
      DrawDoor(ExitDoor,Canvas);          //ExitDoor
      DrawPlats(FPlats,Canvas);           //Platforms(Fixed)
      DrawPlats(RandPlats,Canvas);        //Platforms(Random)
      DrawBullet(Bullets,Canvas);         //Bullets
      DrawText(gametext,Canvas);          //Text
      DrawAi(Ai,Canvas);                  //Ai
      DrawPlayer(Player,Canvas);          //Player
      DrawTurret(Turrets,Canvas);         //Turrets

      DrawButton(Options[8], 20, Canvas); //Draw the button to go to settings
      DrawButton(Options[9], 20, Canvas); //Draw the button to restart
      DrawButton(Options[10], 20, Canvas); //Draw the button to go back to the level selector

      PostionMoveButtons(GameView.Width, GameView.Height); //Position the controls buttons
      for var i := 0 to High(ControlButtons) do //Draw all the controls button
        begin
          DrawControlButton(ControlButtons[i], 20, Canvas);
        end;

      //If mouse is click and it is over the settings button, open the settings menu
      GameView.OnMouseDown := MouseDown;

      //Code for if the touches change
      GameView.OnTouchBegin := Touch;

      GameView.OnTouchMove := Touch;

      GameView.OnTouchEnd := Touch;

      //If the click is released, stop the player moving
      GameView.OnMouseUp := procedure(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer)
        begin
          KeyUpEvent(LeftKey);
          KeyUpEvent(RightKey);
        end;

      GameView.OnMouseMove := procedure (o : TObject; ss : TShiftState; x, y : integer)
        begin
          MouseX := x;
          MouseY := y;
        end;

      //If any controls are mentioned in text, they must be updated here every frame
      //so that if the control gets updated, so will the text.
      case Level of
        1 : begin
              gametext[0].text := 'Use ' + CodeToKeyName(LeftKey) + ' and ' +
                                  CodeToKeyName(RightKey) + ' to move left and right';
              gametext[1].text := 'Use ' + CodeToKeyName(EnterKey) + ' to go through the door';
            end;
        2 : gametext[0].text := 'Use ' + CodeToKeyName(JumpKey) + ' to jump';
        4 : gametext[0].text := 'Use ' + CodeToKeyName(FallKey) + ' to fall through the platform';
        7 : gametext[3].text := 'Use ' + CodeToKeyName(ShootKey) + ' to shoot stright';
      end;
      //Restart the level is the player is dead, and below the gameView.Height/maxY
      if (Player.dead = True) and (Player.Y > GameView.Height) and (Player.Y > maxY) then
        begin
          LevelStarter(Level); //restarts the Level
        end;
     end;
  if gamemode = settings then //Settings
    begin
      //no offset for display so it is all on the screen
      offsetX := 0;
      offsetY := 0;

      //Clear background
      Canvas.FillStyle := 'white';
      Canvas.BeginPath;
      Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
      Canvas.ClosePath;
      Canvas.Fill;

      //Update the controls list
      Controls[0] := TText.Create('Jump: ' + CodeToKeyName(JumpKey), 'blue', 700, 50);
      Controls[1] := TText.Create('Fall: ' + CodeToKeyName(FallKey), 'blue', 700, 100);
      Controls[2] := TText.Create('Left: ' + CodeToKeyName(LeftKey), 'blue', 700, 150);
      Controls[3] := TText.Create('Right: ' + CodeToKeyName(RightKey), 'blue', 700, 200);
      Controls[4] := TText.Create('Shoot: ' + CodeToKeyName(ShootKey), 'blue', 700, 250);
      Controls[5] := TText.Create('Enter/Use: ' + CodeToKeyName(EnterKey), 'blue', 700, 300);
      Controls[6] := TText.Create('Escape: ' + CodeToKeyName(EscapeKey), 'blue', 700, 350);


      //Draw each option button
      DrawButton(Options[0], 40, Canvas);
      DrawButton(Options[1], 40, Canvas);
      DrawButton(Options[2], 40, Canvas);
      DrawButton(Options[3], 40, Canvas);
      DrawButton(Options[4], 40, Canvas);
      DrawButton(Options[5], 40, Canvas);
      DrawButton(Options[6], 40, Canvas);
      DrawButton(Options[7], 40, Canvas);

      //Draw the controls list
      DrawText(Controls, Canvas, 25);

      //Draw the text saying what your about to change/you have changed it
      Canvas.FillStyle := 'blue';
      Canvas.Font := '20pt verdana';
      if Changed <> 0 then
        begin
          Canvas.FillTextF("Key was changed!", 10, 110, MaxInt());
        end
      else if EscapeKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Escape", 10, 110, MaxInt());
        end
      else if EnterKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Enter Door/Use", 10, 110, MaxInt());
        end
      else if LeftKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Move Left", 10, 110, MaxInt());
        end
      else if JumpKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Jump", 10, 110, MaxInt());
        end
      else if FallKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Fall", 10, 110, MaxInt());
        end
      else if RightKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Move Right", 10, 110, MaxInt());
        end
      else if ShootKeyChange then
        begin
          Canvas.FillTextF("Click the desired key to be Shoot", 10, 110, MaxInt());
        end;

     //If the button is clicked, make that the key being changed
     if Changed = 0 then
        begin
          GameView.OnMouseDown := procedure(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer)
            begin
              if Options[0].clicked(x, y) then
                begin
                  EscapeKeyChange := true;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                end
              else if Options[1].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := true;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                end
              else if Options[2].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := true;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                end
              else if Options[3].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := true;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                end
              else if Options[4].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := true;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                end
              else if Options[5].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := true;
                  ShootKeyChange := false;
                end
              else if Options[6].clicked(x, y) then
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := true;
                end
              else if Options[7].clicked(x, y) then //Exits to the game again
                begin
                  EscapeKeyChange := false;
                  EnterKeyChange := false;
                  LeftKeyChange := false;
                  JumpKeyChange := false;
                  FallKeyChange := false;
                  RightKeyChange := false;
                  ShootKeyChange := false;
                  if Level = 0 then
                    begin
                      gamemode := levelselector;
                    end
                  else
                    begin
                      gamemode := maingame;
                    end;
               end;
            end;
        end;
    end;
end;

procedure PostionMoveButtons(GameWidth, GameHeight : float); //Positions all the control buttons onto the
                                                             //screen in the correct position
begin
  ControlButtons[0] := TOptionsButton.create(10, GameHeight - 40, 50, 30, "Left", 15, GameHeight - 17);
  ControlButtons[1] := TOptionsButton.create(130, GameHeight - 40, 50, 30, "Right", 135 , GameHeight - 17);
  ControlButtons[2] := TOptionsButton.create(70, GameHeight - 40, 50, 30, "Jump", 75, GameHeight - 17);
  ControlButtons[3] := TOptionsButton.create(GameWidth - 60, GameHeight - 100, 50, 30, "Fall", GameWidth - 55, GameHeight - 77);
  ControlButtons[4] := TOptionsButton.create(GameWidth - 60, GameHeight - 40, 50, 30, "Shoot", GameWidth - 55, GameHeight - 17);
  ControlButtons[5] := TOptionsButton.create(10, 50, 60, 30, "Enter Door", 15, 73);
end;

procedure LevelStarter(level : integer); //Starts the stated Level
begin
  //UnlockedDoors := 19; //Added by PPS for the testing version
  case level of
      0: begin //Do nothing if the door failed so the player was not over one
         end;
      1 : begin
      	    if (UnlockedDoors >= 1) then
      	      begin
                lvl1.Initialize();
                UGlobalsNoUserTypes.Level := 1;
                gameMode := maingame;
              end;
         end;
      2 : begin
      	    if (UnlockedDoors >= 2) then
      	      begin
                lvl2.Initialize();
                UGlobalsNoUserTypes.Level := 2;
                gameMode := maingame;
              end;
          end;
      3 : begin
      	    if (UnlockedDoors >= 3) then
      	      begin
               lvl3.Initialize();
                UGlobalsNoUserTypes.Level := 3;
                gameMode := maingame;
              end;
          end;
      4 : begin
      	    if (UnlockedDoors >= 4) then
      	      begin
                lvl4.Initialize();
                UGlobalsNoUserTypes.Level := 4;
                gameMode := maingame;
              end;
         end;
      5 : begin
      	    if (UnlockedDoors >= 5) then
      	      begin
                lvl5.Initialize();
                UGlobalsNoUserTypes.Level := 5;
                gameMode := maingame;
              end;
          end;
      6 : begin
      	    if (UnlockedDoors >= 6) then
      	      begin
               lvl6.Initialize();
               UGlobalsNoUserTypes.Level := 6;
               gameMode := maingame;
              end;
         end;
      7 : begin
      	    if (UnlockedDoors >= 7) then
      	      begin
                lvl7.Initialize();
                UGlobalsNoUserTypes.Level := 7;
                gameMode := maingame;
              end;
          end;
      8 : begin
      	    if (UnlockedDoors >= 8) then
      	      begin
                lvl8.Initialize();
                UGlobalsNoUserTypes.Level := 8;
                gameMode := maingame;
              end;
          end;
      9 : begin
      	    if (UnlockedDoors >= 9) then
      	      begin
                lvl9.Initialize();
                UGlobalsNoUserTypes.Level := 9;
                gameMode := maingame;
              end;
          end;
      10 : begin
      	     if (UnlockedDoors >= 10) then
      	       begin
                 lvl10.Initialize();
                 UGlobalsNoUserTypes.Level := 10;
                 gameMode := maingame;
               end;
           end;
      11 : begin
      	     if (UnlockedDoors >= 11) then
      	       begin
                 lvl11.Initialize();
                 UGlobalsNoUserTypes.Level := 11;
                 gameMode := maingame;
               end;
           end;
      12 : begin
      	     if (UnlockedDoors >= 12) then
      	       begin
                 lvl12.Initialize();
                 UGlobalsNoUserTypes.Level := 12;
                 gameMode := maingame;
               end;
          end;
      13 : begin
      	     if (UnlockedDoors >= 13) then
      	       begin
                 lvl13.Initialize();
                 UGlobalsNoUserTypes.Level := 13;
                 gameMode := maingame;
               end;
          end;
      14 : begin
      	     if (UnlockedDoors >= 14) then
                     begin
                 lvl14.Initialize();
                 UGlobalsNoUserTypes.Level := 14;
                 gameMode := maingame;
               end;
          end;
      15 : begin
      	     if (UnlockedDoors >= 15) then
      	       begin
                 lvl15.Initialize();
                 UGlobalsNoUserTypes.Level := 15;
                 gameMode := maingame;
               end;
          end;
      16 : begin
             if (UnlockedDoors >= 16) then
	             begin
                 lvl16.Initialize();
                 UGlobalsNoUserTypes.Level := 16;
                 gameMode := maingame;
               end;
          end;
      17 : begin
      	     if (UnlockedDoors >= 17) then
      	       begin
                 lvl17.Initialize();
                 UGlobalsNoUserTypes.Level := 17;
                 gameMode := maingame;
               end;
          end;
      else //This will run the last level (at present level 18)
        begin
      	  if (UnlockedDoors >= 18) then
      	    begin
              ClearVARS();
              InDoor(1600, 700);
              OutDoor(100, 200 - UE.HEIGHT - 15);
              FixPlats(EntranceDoor.X, EntranceDoor.Y + UE.HEIGHT, 50, 10);
              FixPlats(ExitDoor.X - 15, ExitDoor.Y + UE.HEIGHT, 50, 10);
              SideScrollSize(2000, 1000);
              PercentofRands(10);
              PercentofVerticals(30);
              PercentofNoFalls(30);
              PercentofJumpThoughs(45);
              PercentofCrumble(10);
              PercentofMovings(25);
              PercentofMovesThatMoveX(30);
              MaxMoveForMoves(1000);
              PercentofTurretsOnLeftorTop(0.7);
              PercentofTurretsOnRightorBottom(0.7);
              SpawnRands();
              UGlobalsNoUserTypes.Level := 18;
              gameMode := maingame;
              StartLvl(0);
            end;
        end;
  end;
end;

procedure SwapKeys(mCode : integer); //Swaps over the keys
var
  CurrentKeyNum : integer; //Stores the integer that represents the key
  CurrentKeyVal : integer; //Stores the integer that is the code for the key
begin
  //Left Key = 0
  //Right Key = 1
  //Jump Key = 2
  //Fall Key = 3
  //Shoot Key = 4
  //Enter Key = 5
  //Escape Key = 6

  //Sets the current key, and its value, and says that the changing key is changed
  if LeftKeyChange then
    begin
      CurrentKeyNum := 0;
      CurrentKeyVal := LeftKey;
      LeftKeyChange := false;
    end
  else if RightKeyChange then
    begin
      CurrentKeyNum := 1;
      CurrentKeyVal := RightKey;
      RightKeyChange := false;
    end
  else if JumpKeyChange then
    begin
      CurrentKeyNum := 2;
      CurrentKeyVal := JumpKey;
      JumpKeyChange := false;
    end
  else if FallKeyChange then
    begin
      CurrentKeyNum := 3;
      CurrentKeyVal := FallKey;
      FallKeyChange := false;
    end
  else if ShootKeyChange then
    begin
      CurrentKeyNum := 4;
      CurrentKeyVal := ShootKey;
      ShootKeyChange := false;
    end
  else if EnterKeyChange then
      begin
      CurrentKeyNum := 5;
      CurrentKeyVal := EnterKey;
      EnterKeyChange := false;
    end
  else if EscapeKeyChange then
    begin
      CurrentKeyNum := 6;
      CurrentKeyVal := EscapeKey;
      EscapeKeyChange := false;
    end;

  for var i := 0 to 6 do //Checks all 7 controls
    begin
      if i = CurrentKeyNum then //If the control being checked is equal to the
                                //Control being changed, just skip the checking
        continue
      else //Otherwise
        case i of //Check the current control to see if it is equal to the mCode, and
                  //change it to the key of the one being changed
                  //then break to loop for efficiency (so it wont check them all
                  //as they cannot overlap, meaning once one overlaps it won't need to find more)
          0 : begin
              if LeftKey = mCode then
                LeftKey := CurrentKeyVal;
              break;
             end;
          1 : begin
              if RightKey = mCode then
                RightKey := CurrentKeyVal;
              break;
             end;
          2 : begin
              if JumpKey = mCode then
                JumpKey := CurrentKeyVal;
              break;
             end;
          3 : begin
              if FallKey = mCode then
                FallKey := CurrentKeyVal;
              break;
             end;
          4 : begin
              if ShootKey = mCode then
                ShootKey := CurrentKeyVal;
              break;
             end;
          5 : begin
              if EnterKey = mCode then
                EnterKey := CurrentKeyVal;
              break;
             end;
          6 : begin
              if EscapeKey = mCode then
                EscapeKey := CurrentKeyVal;
              break;
             end;
          end;
    end;

  //Then swap the control getting changed so it is now equal to the mCode
  if CurrentKeyNum = 0 then
      LeftKey := mCode
  else if CurrentKeyNum = 1 then
      RightKey := mCode
  else if CurrentKeyNum = 2 then
      JumpKey := mCode
  else if CurrentKeyNum = 3 then
      FallKey := mCode
  else if CurrentKeyNum = 4 then
      ShootKey := mCode
  else if CurrentKeyNum = 5 then
      EnterKey := mCode
  else if CurrentKeyNum = 6 then
      EscapeKey := mCode;
end;

end.
