unit UDrawing;

interface

uses 
  W3System, W3Graphics,
  UMouseInputs, UArrow, UArcher, UPlayer, UEnemy, UGroundUnit, UAirUnit, UGameVariables, UShop, UShopItem, UTextures, UScalingInfo;

procedure ClearScreen(canvas : TW3Canvas);
procedure DrawLoadingScreen(canvas : TW3Canvas);
procedure DrawScenery(canvas : TW3Canvas);
procedure DrawPlayer(player : TPlayer; canvas : TW3Canvas);
procedure DrawArcher(archer : TArcher; canvas : TW3Canvas);
procedure DrawArrow(arrows : array of TArrow; canvas : TW3Canvas); overload;
procedure DrawArrow(arrow : TArrow; canvas : TW3Canvas); overload;
procedure DrawEnemy(enemy : array of TEnemy; canvas : TW3Canvas); overload;
procedure DrawEnemy(enemy : TEnemy; canvas : TW3Canvas); overload;
procedure DrawMouseDragLine(player : TPlayer; canvas : TW3Canvas);
procedure DrawCanShoot(player : TPlayer; canvas : TW3Canvas);
procedure DrawHUD(canvas : TW3Canvas);
procedure DrawPauseScreen(canvas : TW3Canvas);
procedure DrawGameOver(canvas : TW3Canvas);
procedure RotateCanvas(angle, xChange, yChange : float; canvas : TW3Canvas);

implementation

procedure ClearScreen(canvas : TW3Canvas);
begin
  // Clear background
  canvas.FillStyle := "rgb(255, 255, 255)";
  canvas.FillRectF(0, 0, GAMEWIDTH * 2, GAMEHEIGHT * 2);

  // Draw border
  canvas.StrokeStyle := "rgb(0, 0, 0)";
  canvas.LineWidth := 4;
  canvas.StrokeRectF(0, 0, GAMEWIDTH, GAMEHEIGHT);
end;

procedure DrawLoadingScreen(canvas : TW3Canvas);
begin
  canvas.FillStyle := "blue";
  canvas.Font := "24pt verdana";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "middle";
  canvas.FillTextF("Loading Content...", GAMEWIDTH / 2, GAMEHEIGHT / 2, 275);
end;

procedure DrawScenery(canvas : TW3Canvas);
begin
  canvas.DrawImageF(TowerTexture.Handle, 0, GAMEHEIGHT - TowerTexture.Handle.height);

  // Draw the shop button
  canvas.StrokeStyle := "rgb(0, 0, 0)";
  canvas.LineWidth := 4;
  canvas.FillStyle := "rgb(130, 120, 140)";
  canvas.StrokeRect(PauseButtonRect());
  canvas.FillRect(PauseButtonRect());

  // Get the correct text
  var text := "Shop";
  if Paused then
    begin
      text := "Resume";
    end;

  // Put the text in the button
  canvas.Font := IntToStr(Round(PauseButtonRect().Width() / 4)) + "pt verdana";
  canvas.FillStyle := "rgb(0, 0, 0)";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "middle";
  canvas.FillTextF(text, PauseButtonRect().CenterPoint().X, PauseButtonRect().CenterPoint().Y, PauseButtonRect().Width() - 10);
end;

procedure DrawPlayer(player : TPlayer; canvas : TW3Canvas);
begin
  // Draw the player
  DrawArcher(player, canvas);

  // Draw the extra archers
  for var i := 0 to High(player.ExtraArchers) do
    begin
      DrawArcher(player.ExtraArchers[i], canvas);
    end;
end;

procedure DrawArcher(archer : TArcher; canvas : TW3Canvas);
begin
  // Draw the body of the archer
  canvas.DrawImageF(ArcherTexture.Handle, archer.X, archer.Y);

  // Rotate the canvas for the bow
  RotateCanvas(archer.Angle(), archer.X + ArcherTexture.Handle.width / 2, archer.Y + ArcherTexture.Handle.height / 3, canvas);

  // Draw the bow
  canvas.DrawImageF(BowTexture.Handle, archer.X + ArcherTexture.Handle.width / 2, archer.Y + ArcherTexture.Handle.height / 3 - BowTexture.Handle.height / 2);

  // Draw the string drawback
  canvas.StrokeStyle := "rgb(0, 0, 0)";
  canvas.LineWidth := 0.1;
  canvas.BeginPath();
  canvas.MoveToF(archer.X + ArcherTexture.Handle.width / 2 + BowTexture.Handle.width * 3 / 5, archer.Y + ArcherTexture.Handle.height / 3 - BowTexture.Handle.height / 2);
  canvas.LineToF(archer.X + ArcherTexture.Handle.width / 2 + BowTexture.Handle.width * 3 / 5 - archer.Power() / 3, archer.Y + ArcherTexture.Handle.height / 3);
  canvas.MoveToF(archer.X + ArcherTexture.Handle.width / 2 + BowTexture.Handle.width * 3 / 5, archer.Y + ArcherTexture.Handle.height / 3 + BowTexture.Handle.height / 2);
  canvas.LineToF(archer.X + ArcherTexture.Handle.width / 2 + BowTexture.Handle.width * 3 / 5 - archer.Power() / 3, archer.Y + ArcherTexture.Handle.height / 3);
  canvas.ClosePath();
  canvas.Stroke();

  // Un-rotate the canvas
  RotateCanvas(-archer.Angle(), archer.X + ArcherTexture.Handle.width / 2, archer.Y + ArcherTexture.Handle.height / 3, canvas);
end;

procedure DrawArrow(arrows : array of TArrow; canvas : TW3Canvas);
begin
  for var i := 0 to High(arrows) do
    begin
      if arrows[i].Active then
        begin
          DrawArrow(arrows[i], canvas);
        end;
    end;
end;

procedure DrawArrow(arrow : TArrow; canvas : TW3Canvas);
begin
  // Rotate the canvas
  RotateCanvas(arrow.GetAngle(), arrow.X, arrow.Y, canvas);

  // Draw the arrow
  canvas.DrawImageF(ArrowTexture.Handle, arrow.X, arrow.Y);

  // Rotate the canvas back
  RotateCanvas(-arrow.GetAngle(), arrow.X, arrow.Y, canvas);
end;

procedure DrawEnemy(enemy : array of TEnemy; canvas : TW3Canvas); overload;
begin
  for var i := 0 to High(enemy) do
    begin
      if not enemy[i].Dead then
        begin
          DrawEnemy(enemy[i], canvas);
        end;
    end;
end;

procedure DrawEnemy(enemy : TEnemy; canvas : TW3Canvas); overload;
var
  textureWidth : integer;
  greenWidth : float;
begin
  if (enemy is TGroundUnit) then
    begin
      // Draw the ground unit if it is one
      canvas.DrawImageF(GroundUnitTexture.Handle, enemy.X, enemy.Y);

      // Draw it frozen if it's meant to be
      if enemy.Frozen then
        begin
          canvas.DrawImageF(FrozenGroundUnitTexture.Handle, enemy.X, enemy.Y);
        end;

      // Store the texture's width
      textureWidth := GroundUnitTexture.Handle.width;
    end
  else if (enemy is TAirUnit) then
    begin
      // Draw the air unit if it is one
      canvas.DrawImageF(AirUnitTexture.Handle, enemy.X, enemy.Y);

      // Draw it frozen if it's meant to be
      if enemy.Frozen then
        begin
          canvas.DrawImageF(FrozenAirUnitTexture.Handle, enemy.X, enemy.Y);
        end;

      // Store the texture's width
      textureWidth := AirUnitTexture.Handle.width;
    end;

  // Draw the health bar's red underlay above enemy
  canvas.FillStyle := "rgb(200, 0, 0)";
  canvas.FillRectF(enemy.X, enemy.Y - 13, textureWidth, 5);

  // Draw the health bar's green overlay above the enemy
  greenWidth := (enemy.Health / enemy.MaxHealth) * textureWidth; // Get the percentage of health and multiply by the bar's width
  canvas.FillStyle := "rgb(0, 200, 0)";
  canvas.FillRectF(enemy.X, enemy.Y - 13, greenWidth, 5);
end;

procedure DrawMouseDragLine(player : TPlayer; canvas : TW3Canvas);
begin
  if MouseDown and not Paused then
    begin
      canvas.StrokeStyle := "rgba(0, 0, 0, 0.5)";
      canvas.LineWidth := 0.3;
      canvas.BeginPath();
      canvas.MoveToF(MouseDownX, MouseDownY);
      canvas.LineToF(CurrentMouseX, CurrentMouseY);
      canvas.ClosePath();
      canvas.Stroke();
    end;
end;

procedure DrawCanShoot(player : TPlayer; canvas : TW3Canvas);
var
  text : string; // Text to go in message for the colour blind
begin
  // Get red (can't shoot) or green (can shoot) fillers
  if player.CanShoot then
    begin
      canvas.FillStyle := "rgba(0, 200, 0, 0.5)";
      text := "Can shoot";
    end
  else
    begin
      canvas.FillStyle := "rgba(200, 0, 0, 0.5)";
      text := "Can't shoot";
    end;

  // Draw a circle around the mouse
  canvas.BeginPath();
  canvas.Ellipse(CurrentMouseX - 7, CurrentMouseY - 7, CurrentMouseX + 7, CurrentMouseY + 7);
  canvas.ClosePath();
  canvas.Fill();

  // Draw a message saying "can/can't shoot" for the colour blind
  canvas.Font := "10pt verdana";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "bottom";
  canvas.FillTextF(text, CurrentMouseX, CurrentMouseY - 12, MAX_INT);

  // Also draw this message again above the player for those on a mobile as they can't see through their thumbs
  canvas.FillTextF(text, player.X + ArcherTexture.Handle.width / 2, player.Y - 12, MAX_INT)
end;

procedure DrawPauseScreen(canvas : TW3Canvas);
begin
  // Draw shop
  Shop.Draw(canvas);

  // The x position to place instructions and the side padding
  var xPos := Shop.Items[0].X + SHOP_WIDTH + 30;
  var sidePadding := 30;

  // Draw the title
  canvas.FillStyle := "rgb(0, 0, 0)";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "top";
  canvas.FillTextF("Welcome to TowerOfArcher!", xPos + (GAMEWIDTH - xPos - sidePadding) / 2, 50, GAMEWIDTH - xPos - sidePadding);

  // Draw instructions
  canvas.Font := "16pt verdana";
  canvas.TextAlign := "left";
  canvas.TextBaseLine := "top";
  canvas.FillTextF("How to play:", xPos, 90, GAMEWIDTH - xPos);
  canvas.FillTextF("To aim, hold down the left mouse button and drag backwards.", xPos + 40, 130, GAMEWIDTH - xPos - 40 - sidePadding);
  canvas.FillTextF("Release the left mouse button to fire.", xPos + 40, 170, GAMEWIDTH - xPos - 40 - sidePadding);
  canvas.FillTextF("You can cancel the shot by right-clicking.", xPos + 40, 210, GAMEWIDTH - xPos - 40 - sidePadding);
  canvas.FillTextF("If 10 enemies reach your castle, you lose!", xPos + 40, 250, GAMEWIDTH - xPos - 40 - sidePadding);
  canvas.FillTextF("Don't forget to check the shop regularly for upgrades!", xPos + 40, 290, GAMEWIDTH - xPos - 40 - sidePadding);
end;

procedure DrawHUD(canvas : TW3Canvas);
begin
  canvas.FillStyle := "rgb(220, 20, 50)";
  canvas.Font := "15pt verdana";
  canvas.TextAlign := "right";
  canvas.TextBaseLine := "top";
  canvas.FillTextF("Lives: " + IntToStr(Lives), GAMEWIDTH - 20, 10, MAX_INT);
  canvas.FillStyle := "rgb(220, 220, 20)";
  canvas.FillTextF("Gold: $" + IntToStr(Money), GAMEWIDTH - 20, 40, MAX_INT);
end;

procedure DrawGameOver(canvas : TW3Canvas);
begin
  // Draw the text
  canvas.Font := "70pt verdana";
  canvas.FillStyle := "rgb(0, 0, 0)";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "top";
  canvas.FillTextF("Game Over!", GAMEWIDTH / 2, 50, MAX_INT);

  // Draw the button
  canvas.StrokeStyle := "rgb(0, 0, 0)";
  canvas.LineWidth := 4;
  canvas.FillStyle := "rgb(130, 120, 140)";
  canvas.StrokeRect(RestartButtonRect());
  canvas.FillRect(RestartButtonRect());

  // Put the text in the button
  canvas.Font := IntToStr(Round(RestartButtonRect().Width() / 4)) + "pt verdana";
  canvas.FillStyle := "rgb(0, 0, 0)";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "middle";
  canvas.FillTextF("Restart", RestartButtonRect().CenterPoint().X, RestartButtonRect().CenterPoint().Y, RestartButtonRect().Width() - 10);
end;

procedure RotateCanvas(angle, xChange, yChange : float; canvas : TW3Canvas);
begin
  // Trasnlate the canvas so the 0,0 point is the center of the object being rotated
  canvas.Translate(xChange, yChange);

  // Rotate the canvas
  canvas.Rotate(angle);

  // Detranslate the canvas so the 0,0 point is the normal one
  canvas.Translate(-xChange, -yChange);
end;

end.
