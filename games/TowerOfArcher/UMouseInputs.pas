unit UMouseInputs;

interface

uses 
  W3System, W3Components, W3Touch,
  USpawner, UGameVariables, UGameItems, UPlayerData, UShop, UShopData, UScalingInfo;

procedure DownHandler(b : TMouseButton; x, y : integer);
procedure UpHandler(b : TMouseButton; x, y : integer);
procedure MoveHandler(x, y : integer);
procedure MouseDownHandler(sender : TObject; b : TMouseButton; t : TShiftState; x, y : integer);
procedure MouseUpHandler(sender : TObject; b : TMouseButton; t : TShiftState; x, y : integer);
procedure MouseMoveHandler(sender : TObject; ss : TShiftState; x, y : integer);
procedure TouchDownHandler(sender : TObject; td : TW3TouchData);
procedure TouchUpHandler(sender : TObject; td : TW3TouchData);
procedure TouchMoveHandler(sender : TObject; td : TW3TouchData);
procedure ChangeTimers(pause : boolean);

var
  MouseDown : boolean;
  MouseDownX, MouseDownY, CurrentMouseX, CurrentMouseY : integer;

implementation

procedure DownHandler(b : TMouseButton; x, y : integer);
begin
  // Make the x and y values correct due to scaling
  x := Round(x * (1 / Scale));
  y := Round(y * (1 / Scale));

  // Only make the mouse down if the left mouse button is pressed
  if (b = TMouseButton.mbLeft) and (Lives > 0) then
    begin
      MouseDown := true;
      MouseDownX := x;
      MouseDownY := y;
      CurrentMouseX := x;
      CurrentMouseY := y;
    end;
end;

procedure UpHandler(b : TMouseButton; x, y : integer);
begin
  // Make the x and y values correct due to scaling
  x := Round(x * (1 / Scale));
  y := Round(y * (1 / Scale));

  // Only check the restart button if the player has lost
  if Lives <= 0 then
    begin
      if RestartButtonRect().ContainsPoint(TPoint.Create(x, y)) then
        begin
          // Tell the main program that the restart button was clicked
          RestartClicked := true;
        end;

      // Stop other mouse input checks
      exit;
    end;

  // Change whether the game is paused if the shop/resume button was clicked
  if (MouseDown) and (b = TMouseButton.mbLeft) and (PauseButtonRect().ContainsPoint(TPoint.Create(x, y))) then
    begin
      MouseDown := false;

      // Pause/Resume all timers
      ChangeTimers(Paused);

      // Invert the paused variable
      Paused := not Paused;

      // Clear the shop message
      PurchaseMessage := "";
    end
  else if not Paused then
    begin
      // Only fire if the left mouse button was clicked
      if (MouseDown) and (b = TMouseButton.mbLeft) then
        begin
          Player.Fire();
        end;

      // Set the player's velocities to 0 to avoid display issues
      Player.UpdateInformation(0, 0, 0, 0);
    end
  else
    begin
      // Check what has been clicked in the shop
      Shop.CheckClicked(x, y);
    end;

  MouseDown := false;
end;

procedure MoveHandler(x, y : integer);
begin
  // Make the x and y values correct due to scaling
  x := Round(x * (1 / Scale));
  y := Round(y * (1 / Scale));

  // Store mouse position
  CurrentMouseX := x;
  CurrentMouseY := y;

  if (MouseDown) and (not Paused) and (Lives > 0) then
    begin
      Player.UpdateInformation(MouseDownX, MouseDownY, CurrentMouseX, CurrentMouseY);
    end;
end;

procedure MouseDownHandler(sender : TObject; b : TMouseButton; t : TShiftState; x, y : integer);
begin
  DownHandler(b, x, y);
end;

procedure MouseUpHandler(sender : TObject; b : TMouseButton; t : TShiftState; x, y : integer);
begin
  UpHandler(b, x, y);
end;

procedure MouseMoveHandler(sender : TObject; ss : TShiftState; x, y : integer);
begin
  MoveHandler(x, y);
end;

procedure TouchDownHandler(sender : TObject; td : TW3TouchData);
begin
  DownHandler(TMouseButton.mbLeft, td.Touches.Touches[0].PageX, td.Touches.Touches[0].PageY);
end;

procedure TouchUpHandler(sender : TObject; td : TW3TouchData);
begin
  // Use previous x and y positions as the Touch has been removed
  UpHandler(TMouseButton.mbLeft, Round(CurrentMouseX * Scale), Round(CurrentMouseY * Scale));
end;

procedure TouchMoveHandler(sender : TObject; td : TW3TouchData);
begin
  MoveHandler(td.Touches.Touches[0].PageX, td.Touches.Touches[0].PageY);
end;

procedure ChangeTimers(pause : boolean);
begin
  if pause then
    begin
      // Resume timers if being un-paused
      Player.ResumeTimer();
      StartEnemySpawners();
      for var i := 0 to High(Enemies) do
        begin
          Enemies[i].ResumeTimer();
        end;
    end
  else
    begin
      // Pause timers if being paused
      Player.PauseTimer();
      PauseEnemySpawners();
      for var i := 0 to High(Enemies) do
        begin
          Enemies[i].PauseTimer();
        end;
    end;
end;

end.
