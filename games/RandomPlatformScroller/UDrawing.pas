unit UDrawing;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
//This unit contains all the code for drawing objects
interface

uses
  W3System, W3Graphics,
  UPlayer, UAi, UE, UPlat, UBullet, UGameText, UTurret, UOptionsButton, UGlobals, UGlobalsNoUserTypes;

procedure DrawButton(Button : TOptionsButton; FontSize : integer; Canvas: TW3Canvas);
procedure DrawControlButton(Button : TOptionsButton; FontSize : integer; Canvas: TW3Canvas);
procedure DrawPlayer(player : UPlayer.TPlayer; Canvas: TW3Canvas);
procedure DrawAI(AI : array of UAi.TAi; Canvas: TW3Canvas);
procedure DrawDoors(Door : array of UE.TE; Canvas: TW3Canvas);
procedure DrawDoor(Door : UE.TE; Canvas: TW3Canvas; Locked : boolean = false);
procedure DrawPlats(Plat : array of UPlat.TPlat; Canvas: TW3Canvas);
procedure DrawBullet(Bullet : array of UBullet.TBullet; Canvas: TW3Canvas);
procedure DrawText(text : array of UGameText.TText; Canvas: TW3Canvas; FontSize : integer = 10);
procedure DrawTurret(Turrets : array of TTurret; Canvas: TW3Canvas);
function OnScreen(x, y, x2, y2 : float) : boolean;

implementation

procedure DrawButton(Button : TOptionsButton; FontSize : integer; Canvas: TW3Canvas);
begin
  Canvas.FillStyle := 'red';
  Canvas.BeginPath;
  Canvas.FillRectF(Button.X, Button.Y, Button.Width, Button.Height);
  Canvas.ClosePath;
  Canvas.Fill;
  Canvas.FillStyle := 'blue';
  Canvas.Font := IntToStr(FontSize) + 'pt verdana';
  Canvas.FillTextF(Button.Text, Button.TextX, Button.TextY, Button.Width - (2 * (Button.TextX - Button.X)));
end;

procedure DrawControlButton(Button : TOptionsButton; FontSize : integer; Canvas: TW3Canvas);
begin
  var AlphaBlendingValue := 0.3; //The value we shall use for the Alpha blending
  if gamemode = levelselector then //If the gamemode is the level selector
    begin
      for var i := 0 to High(Selector.Text) do //Goes through the text in the level selector
        begin
          var Len := Selector.Text[i].text.Length * 10; //The length of the text. we time it
                                                        //by 10 as we use font size 10 so it it
                                                        //a rough estimation of the length
          if (Selector.Text[i].x - offsetX < Button.X + Button.Width) and //Works out if the x overlaps
             (Selector.Text[i].x - offsetX + Len > Button.X) then
             begin
               if (Selector.Text[i].y - offsetY < Button.Y + Button.Height) and //Works out if the y overlaps
                  (Selector.Text[i].y - offsetY + 10 > Button.Y) then
                 AlphaBlendingValue := 0.05; //If it does, make it more transparent so the text can be read with ease
             end;
        end;
    end
  else //Otherwise it is in the maingame
    begin
      for var i := 0 to High(gameText) do //Goes through the gameTexts
        begin
          var Len := gameText[i].text.Length * 10; //The length of the text. We multiply it
                                                   //by 10 as we use font size 10 so it it
                                                   //a rough estimation of the length
          if (gameText[i].x - offsetX < Button.X + Button.Width) and //Works out if the x overlaps
             (gameText[i].x - offsetX + Len > Button.X) then
             begin
               if (gameText[i].y - offsetY < Button.Y + Button.Height) and //Works out if the y overlaps
                  (gameText[i].y - offsetY + 10 > Button.Y) then
                 AlphaBlendingValue := 0.05; //If it does, make it more transparent so the text can be read with ease
             end;
        end;
    end;
  Canvas.FillStyle := 'rgba(130, 130, 130, ' + floatToStr(AlphaBlendingValue) + ')';
  Canvas.BeginPath;
  Canvas.FillRectF(Button.X, Button.Y, Button.Width, Button.Height);
  Canvas.ClosePath;
  Canvas.Fill;
  Canvas.FillStyle := 'rgba(0, 0, 0, ' + floatToStr(AlphaBlendingValue) + ')';
  Canvas.Font := IntToStr(FontSize) + 'pt verdana';
  Canvas.FillTextF(Button.Text, Button.TextX, Button.TextY, Button.Width - (2 * (Button.TextX - Button.X)));
end;

procedure DrawPlayer(player : UPlayer.TPlayer; Canvas: TW3Canvas);
begin
  if (OnScreen(player.X,player.Y,player.X + PLAYERHEAD,player.Y + PLAYERHEIGHT)) then
    begin
      //Draw the body
      Canvas.FillStyle := player.colour;
      Canvas.BeginPath;
      Canvas.Ellipse(player.X - offsetX, player.Y - offsetY, player.X + PLAYERHEAD - offsetX, player.Y + PLAYERHEAD - offsetY);
      Canvas.Ellipse(player.X - offsetX, player.Y + PLAYERHEAD - offsetY, player.X + PLAYERHEAD - offsetX, player.Y + PLAYERHEAD + 10 - offsetY);
      Canvas.FillRectF(player.X - offsetX, player.Y + PLAYERHEAD + 5 - offsetY, PLAYERHEAD, PLAYERHEIGHT - PLAYERHEAD - 5);
      Canvas.ClosePath;
      Canvas.Fill;
      //Draw the gun
      if player.FaceLeft then
        begin
          Canvas.FillStyle := 'black';
          Canvas.BeginPath;
          Canvas.FillRectF(player.X - UBullet.WIDTH + 3 - offsetX, player.Y + PLAYERHEAD + 3 - offsetY, UBullet.WIDTH, UBullet.HEIGHT);
          Canvas.FillRectF(player.X - 1 - offsetX, player.Y + PLAYERHEAD + 3 + UBullet.HEIGHT - offsetY, 4, 8);
          Canvas.ClosePath;
          Canvas.Fill;
        end
      else
        begin
          Canvas.FillStyle := 'black';
          Canvas.BeginPath;
          Canvas.FillRectF(player.X + PLAYERHEAD - 3 - offsetX, player.Y + PLAYERHEAD + 3 - offsetY, UBullet.WIDTH, UBullet.HEIGHT);
          Canvas.FillRectF(player.X + PLAYERHEAD - 3 - offsetX, player.Y + PLAYERHEAD + 3 + UBullet.HEIGHT - offsetY, 4, 8);
          Canvas.ClosePath;
          Canvas.Fill;
        end;
      //Draw the health
      if player.Health >= 1 then //State health above player
        begin
          Canvas.Font := '10pt verdana';
          Canvas.FillStyle := player.Colour;
          Canvas.FillTextF(IntToStr(Round(player.Health)), player.x - offsetX,
                           player.y - offsetY - 10, PLAYERHEAD);
        end
     else //Says dead if the player is dead
       begin
         Canvas.Font := '10pt verdana';
         Canvas.FillStyle := player.Colour;
         Canvas.FillTextF("Dead", player.x - offsetX, player.y - offsetY - 10, PLAYERHEAD);
       end;
    end;
end;

procedure DrawAI(AI : array of UAi.TAi; Canvas: TW3Canvas);
begin
  var i := 0;
  while i <= High(AI) do //Iterate through the Ai Units
    begin
      DrawPlayer(AI[i], Canvas); //Draws the ai using the draw player code
      i := 1; //Selects the next Ai unit
    end;
end;

procedure DrawDoors(Door : array of UE.TE; Canvas: TW3Canvas); //Mainly for all the doors in the level selector
begin
  var i := 0;
  while i <= High(Door) do //iterate through the doors
    begin
      if (i + 1 > UnlockedDoors) then
        DrawDoor(Door[i], Canvas, true) //Draws the current door using the drawDoor procedure
      else
        DrawDoor(Door[i], Canvas);
      i += 1; //Select next door
    end;
end;

procedure DrawDoor(Door : UE.TE; Canvas: TW3Canvas; Locked : boolean = false);
begin
  if (OnScreen(Door.X,Door.Y,Door.X + UE.WIDTH,Door.Y + UE.HEIGHT)) then
    begin
      if (Locked) then //If the door is locked make it slightly transparent
        Canvas.FillStyle := 'rgba(0, 0, 205, 0.4)'
      else
        Canvas.FillStyle := 'rgb(0, 0, 205)';
      Canvas.BeginPath;
      Canvas.FillRectF(Door.X - offsetX, Door.Y - offsetY, UE.WIDTH, UE.HEIGHT);
      Canvas.ClosePath;
      Canvas.Fill;
    end;
end;

procedure DrawPlats(Plat : array of UPlat.TPlat; Canvas: TW3Canvas);
begin
  var i := 0;
  while i <= High(Plat) do //Iterate through the platforms
    begin

      if (OnScreen(Plat[i].X,Plat[i].Y,Plat[i].X + Plat[i].Width,Plat[i].Y + Plat[i].Height)) then
        begin
          //First set the colour depending on the type of platform it is
          if Plat[i].Crumble then //If it is a crumbling platform
            begin
              Canvas.FillStyle := 'rgba(90, 65, 35, 0.9)'; //set the colour
            end
          else if Plat[i].horizontal then //If the platform is horizontal
            begin
              if Plat[i].jumpThrough then //and you can jump through it
                begin
                  if Plat[i].noFall then //but cannot fall through it
                    Canvas.FillStyle := 'rgba(100, 0, 0, 0.9)' //make it dark red
                  else //and can fall through it
                    Canvas.FillStyle := 'rgba(0, 50, 0, 0.9)'; //make it dark green
                end
              else //and you cannot jump through it
                begin
                  if Plat[i].noFall then //but cannot fall through it
                    Canvas.FillStyle := 'rgba(0, 0, 100, 0.9)' //make it dark blue
                  else //and can fall through it
                    Canvas.FillStyle := 'rgba(0, 0, 0, 0.9)'; //make it black
                end;
            end
          else //if it is vertical
            begin
              if Plat[i].noFall then //and you cannot fall through it
                begin
                  if Plat[i].NoWallJump then //and you cannot wall jump off it
                    Canvas.FillStyle := 'rgba(250, 100, 190, 0.9)' //Make it pink
                  else //and you can wall jump off it
                    Canvas.FillStyle := 'rgba(255, 80, 0, 0.9)'; //make it orange
                end
              else //and you can fall through it
                begin
                  if Plat[i].NoWallJump then //and you cannot wall jump off it
                    Canvas.FillStyle := 'rgba(190, 10, 120, 0.9)' //Make it purple
                  else //and you can wall jump off it
                    Canvas.FillStyle := 'rgba(100, 100, 100, 0.9)'; //make it grey
                end;
            end;
          Canvas.BeginPath; //Draw the platform
          Canvas.FillRectF(Plat[i].X - offsetX, Plat[i].Y - offsetY, Plat[i].Width,
                           Plat[i].Height);
          Canvas.ClosePath;
          Canvas.Fill;
        end;

      if Plat[i].Moves then //Updates moving platforms
        begin
          var VectorforPlayer := Plat[i].MoveUpdate(Player.X,Player.Y,Player.X + PLAYERHEAD,Player.Y + PLAYERHEIGHT);
          Player.X += VectorforPlayer[0]; //add the needed x change from being on a moving platform
          Player.Y += VectorforPlayer[1]; //add the needed y change from being on a moving platform
        end;
      if (Plat[i].Crumble) and (Plat[i].Y <= maxY + 2500) then
        Plat[i].CrumbleUpdate(); //Update the crumble platforms

      i += 1; //Select the next platform
   end;
end;

procedure DrawBullet(Bullet : array of UBullet.TBullet; Canvas: TW3Canvas);
begin
  Canvas.FillStyle := 'green';
  var i := 0;
  while i <= High(Bullet) do //iterate through the bullets
    begin
      if (OnScreen(Bullet[i].X,Bullet[i].Y,Bullet[i].X + UBullet.WIDTH,Bullet[i].Y + UBullet.HEIGHT)) then
        begin
          //Set 0, 0 point to the centre of the Bullet
          Canvas.Translate(Bullet[i].X + UBullet.WIDTH/2 - offsetX, Bullet[i].Y + UBullet.HEIGHT/2 - offsetY);
          //Rotate the Bullet
          Canvas.Rotate((Bullet[i].Angle + 90) * PI / 180);
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Bullet[i].X + UBullet.WIDTH/2 - offsetX), -(Bullet[i].Y + UBullet.HEIGHT/2 - offsetY));

          Canvas.BeginPath;
          Canvas.FillRectF(Bullet[i].X - offsetX, Bullet[i].Y - offsetY, UBullet.WIDTH,
                           UBullet.HEIGHT);
          Canvas.ClosePath;
          Canvas.Fill;

          //Set 0, 0 point to the centre of the Bullet
          Canvas.Translate(Bullet[i].X + UBullet.WIDTH/2 - offsetX, Bullet[i].Y + UBullet.HEIGHT/2 - offsetY);
          //Rotate the Canvas to normal
          Canvas.Rotate(-(Bullet[i].Angle + 90) * PI / 180);
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Bullet[i].X + UBullet.WIDTH/2 - offsetX), -(Bullet[i].Y + UBullet.HEIGHT/2 - offsetY));
        end;
      i += 1; //Select the next bullet
   end;
end;

procedure DrawText(text : array of UGameText.TText; Canvas: TW3Canvas; FontSize : integer = 10);
begin
  var i := 0;
  while i <= High(text) do //Iterate through the text
    begin
      Canvas.Font := IntToStr(FontSize) + 'pt verdana';
      Canvas.FillStyle := text[i].Colour;
      Canvas.FillTextF(text[i].text, text[i].x - offsetX, text[i].y - offsetY, MAX_INT);
      i += 1; //Select the next text item
   end;
   Canvas.Font := '10pt verdana';
   Canvas.FillStyle := 'red';
   if gamemode = maingame then //Draws text needed always in levels
     begin
       Canvas.FillTextF('Level: ' + IntToStr(Level), 240, 40, MAX_INT);
      end
   else if gamemode = levelselector then //Draws text always needed in the level selector
     begin
       Canvas.FillTextF('Level Selector', 80, 40, MAX_INT);
     end;
end;


procedure DrawTurret(Turrets : array of TTurret; Canvas: TW3Canvas);   //different side support
begin
  for var i := 0 to High(Turrets) do
    begin
      if OnScreen(Turrets[i].X, Turrets[i].Y, Turrets[i].X + UTurret.WIDTH, Turrets[i].Y + UTurret.HEIGHT) then
        begin
          var TurretRotation : float; //Sets the angle of the turret, so the rounded part faces the correct way
          if Turrets[i].Placement = Bottom then
            TurretRotation := 0
          else if Turrets[i].Placement = Top then
            TurretRotation := 180
          else if Turrets[i].Placement = Left then
            TurretRotation := 270
          else if Turrets[i].Placement = Right then
            TurretRotation := 90;

          //Set the 0, 0 point to the centre of the Turret
          Canvas.Translate(Turrets[i].X + UTurret.WIDTH/2 - offsetX, Turrets[i].Y + UTurret.HEIGHT/2 - offsetY);
          //Rotate the angle of the Turret according to what side it is placed on
          Canvas.Rotate((TurretRotation) * PI / 180);
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Turrets[i].X + UTurret.WIDTH/2 - offsetX), -(Turrets[i].Y + UTurret.HEIGHT/2 - offsetY));

          Canvas.FillStyle := 'blue';
          Canvas.BeginPath;
          Canvas.Ellipse(Turrets[i].X - offsetX, Turrets[i].Y - offsetY, Turrets[i].X + UTurret.WIDTH - offsetX, Turrets[i].Y + ((UTurret.HEIGHT/3) * 2) - offsetY);
          Canvas.FillRectF(Turrets[i].X - offsetX, Turrets[i].Y + (UTurret.HEIGHT/3) - offsetY, UTurret.WIDTH, (UTurret.HEIGHT/3) * 2);
          Canvas.ClosePath;
          Canvas.Fill;

          //Set the 0, 0 point to the centre of the Turret
          Canvas.Translate(Turrets[i].X + UTurret.WIDTH/2 - offsetX, Turrets[i].Y + UTurret.HEIGHT/2 - offsetY);
          //Rotate back to normal
          Canvas.Rotate(-(TurretRotation) * PI / 180);
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Turrets[i].X + UTurret.WIDTH/2 - offsetX), -(Turrets[i].Y + UTurret.HEIGHT/2 - offsetY));


          //Set 0, 0 point to the centre of the Turret
          Canvas.Translate(Turrets[i].X + UTurret.WIDTH/2 - offsetX, Turrets[i].Y + UTurret.HEIGHT/2 - offsetY);
          //Rotate the Stalk of the Turret
          Canvas.Rotate((Turrets[i].Angle) * PI / 180);
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Turrets[i].X + UTurret.WIDTH/2 - offsetX), -(Turrets[i].Y + UTurret.HEIGHT/2 - offsetY));

          Canvas.FillStyle := 'black';
          Canvas.BeginPath;
          Canvas.FillRectF(Turrets[i].X + UTurret.WIDTH/2 - UBullet.HEIGHT/2 - offsetX, Turrets[i].Y + UTurret.HEIGHT/2 - offsetY, UBullet.HEIGHT, -(UTurret.HEIGHT/3) * 2);
          Canvas.ClosePath;
          Canvas.Fill;

          //Set 0, 0 point to the centre of the Turret
          Canvas.Translate(Turrets[i].X + UTurret.WIDTH/2 - offsetX, Turrets[i].Y + UTurret.HEIGHT/2 - offsetY);
          //Rotate back to normal
          Canvas.Rotate(-((Turrets[i].Angle) * PI / 180));
          //Restore the 0, 0 point back to 0, 0
          Canvas.Translate(-(Turrets[i].X + UTurret.WIDTH/2 - offsetX), -(Turrets[i].Y + UTurret.HEIGHT/2 - offsetY));
        end;
    end;
end;

function OnScreen(x, y, x2, y2 : float) : boolean;
begin
  if (x - offsetX <= screenWidth) or (x2 - offsetX >= 0) then //checks if the x is on screen
    begin
      if (y - offsetY <= screenHeight) or (y2 - offsetY >= 0) then //checks if the y is on screen
        Exit(true); //if both succeed, return true
    end;
  Exit(false); //else it is not on screen so return false
end;

end.
