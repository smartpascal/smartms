unit UTowerArcher;

interface

uses
  W3GameApp, W3Graphics, W3Image,
  UDrawing, UMouseInputs, UPlayer, USpawner, UGameVariables, UGameItems, UPlayerData, UShop, UTextures, UScalingInfo;

type
  TApplication = class(TW3CustomGameApplication)
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
  end;

procedure InitializeVariables();
procedure UpdateArrows();
procedure UpdateEnemies();
procedure EvaluateLoadedContent();

var
  ContentLoaded : boolean;
  Loaded : array of boolean;
  FirstLoop : boolean;

implementation

procedure TApplication.ApplicationStarting;
begin
  inherited;
  // Initialize textures
  ArrowTexture := TW3Image.Create(nil);
  ArrowTexture.LoadFromURL("res\Arrow.png");
  BowTexture := TW3Image.Create(nil);
  BowTexture.LoadFromURL("res\Bow.png");
  ArcherTexture := TW3Image.Create(nil);
  ArcherTexture.LoadFromURL("res\Archer.png");
  GroundUnitTexture := TW3Image.Create(nil);
  GroundUnitTexture.LoadFromURL("res\GroundEnemy.png");
  FrozenGroundUnitTexture := TW3Image.Create(nil);
  FrozenGroundUnitTexture.LoadFromURL("res\GroundEnemyFrozen.png");
  AirUnitTexture := TW3Image.Create(nil);
  AirUnitTexture.LoadFromURL("res\AirEnemy.png");
  FrozenAirUnitTexture := TW3Image.Create(nil);
  FrozenAirUnitTexture.LoadFromURL("res\AirEnemyFrozen.png");
  TowerTexture := TW3Image.Create(nil);
  TowerTexture.LoadFromURL("res\Tower.png");

  // Tell the program the content has not loaded
  ContentLoaded := false;
  Loaded := [ false, false, false, false, false, false, false, false ];

  // Add event handlers so loaded content is registered
  ArrowTexture.OnLoad := procedure(o : TObject) begin Loaded[0] := true; end;
  BowTexture.OnLoad := procedure(o : TObject) begin Loaded[1] := true; end;
  ArcherTexture.OnLoad := procedure(o : TObject) begin Loaded[2] := true; end;
  GroundUnitTexture.OnLoad := procedure(o : TObject) begin Loaded[3] := true; end;
  FrozenGroundUnitTexture.OnLoad := procedure(o : TObject) begin Loaded[4] := true; end;
  AirUnitTexture.OnLoad := procedure(o : TObject) begin Loaded[5] := true; end;
  FrozenAirUnitTexture.OnLoad := procedure(o : TObject) begin Loaded[6] := true; end;
  TowerTexture.OnLoad := procedure(o : TObject) begin Loaded[7] := true; end;

  // Initialize the shop
  Shop := TShop.Create();

  // Add the mouse and touch input handlers
  GameView.OnMouseDown := MouseDownHandler;
  GameView.OnMouseUp := MouseUpHandler;
  GameView.OnMouseMove := MouseMoveHandler;
  GameView.OnTouchBegin := TouchDownHandler;
  GameView.OnTouchEnd := TouchUpHandler;
  GameView.OnTouchMove := TouchMoveHandler;

  // Initialize refresh interval
  GameView.Delay := 20;

  // Start the redraw-cycle with frame counter disabled
  GameView.StartSession(True);
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  // Scale the canvas
  ScaleCanvas(GameView.Width, GameView.Height);
  Canvas.Scale(Scale, Scale);

  // Canvas and clear the screen
  ClearScreen(Canvas);

  if ContentLoaded then
    begin
      // Draw player and scenery
      DrawScenery(Canvas);
      DrawPlayer(Player, Canvas);

      // Draw the arrows and enemies
      DrawArrow(Arrows, Canvas);
      DrawEnemy(Enemies, Canvas);

      // Update the arrows and enemies if not in the shop
      if not Paused then
        begin
          UpdateArrows();
          UpdateEnemies();

          // Draw the mouse to origin line if preparing to fire, not paused and not dead
          if Lives > 0 then
            begin
              DrawMouseDragLine(Player, Canvas);
            end;
            
          // Draw a circle over the mouse showing if the player can shoot
          DrawCanShoot(Player, Canvas);
        end
      else
        begin
          // Draw shop/pause screen if it is presently open
          DrawPauseScreen(Canvas);
        end;

      // Draw the information for the player
      DrawHUD(Canvas);

      // Draw the game over screen if dead
      if Lives <= 0 then
        begin
          DrawGameOver(Canvas);
        end;
    end
  else
    begin
      EvaluateLoadedContent();

      DrawLoadingScreen(Canvas);
    end;

  // If the game is over and the restart button has been clicked then restart the game
  if (Lives <= 0) and (RestartClicked) then
    begin
		  PauseEnemySpawners();
      InitializeVariables();
    end;

  // Scale the canvas back to normal
  Canvas.Scale(1 / Scale, 1 / Scale);
end;

procedure InitializeVariables();
begin
  // Initialize the variables
  MaxPower := 30;
  ArrowDamage := 10;
  ArrowsFreeze := false;
  ArrowFreezeDuration := 0;
  TimeBetweenShots := 2000;
  PauseButtonCoordinates := [ 10, 10, 110, 50 ];
  RestartButtonCoordinates := [ Round(GAMEWIDTH / 2 - 50), 200, Round(GAMEWIDTH / 2 + 50), 250 ];
  RestartClicked := false;
  Paused := true;
  Lives := 10;
  Money := 0;

  // Initialize the spawner variables
  GroundDelay := 9000;
  AirDelay := 15000;
  Difficulty := 1000;

  // Reset game items and the shop
  Arrows.Clear();
  Enemies.Clear();
  Shop.ResetItems();

  // Spawn a ground unit
  SpawnGroundUnit();

  // Initialize the player
  Player := TPlayer.Create(TowerTexture.Handle.width - 15 - ArcherTexture.Handle.width, GAMEHEIGHT - TowerTexture.Handle.height - ArcherTexture.Handle.height);
end;

procedure UpdateArrows();
begin
  for var i := 0 to High(Arrows) do
    begin
      if (Arrows[i].Active) then
        begin
          // Get the current x and y positions for the collision engine
          var prevX := Arrows[i].X;
          var prevY := Arrows[i].Y;

          // Move the arrow
          Arrows[i].Move();

          // Check the collisions
          Arrows[i].CheckCollisions(Enemies, prevX, prevY);
        end;
    end;
end;

procedure UpdateEnemies();
begin
  for var i := 0 to High(Enemies) do
    begin
      if not Enemies[i].Dead then
        begin
          // Only move the enemy if it's not frozen
          if not Enemies[i].Frozen then
            begin
              Enemies[i].Move();
            end;
        end;
    end;
end;

procedure EvaluateLoadedContent();
begin
  // Evaluate if everything is loaded
  for var i := 0 to High(Loaded) do
    begin
      // Break the procedure if the content is not loaded
      if not Loaded[i] then
        begin
          exit;
        end;
    end;

  // If the procedure has not ended the content is loaded so check the shop
  if Shop.Loaded then
    begin
      // State the content has all loaded
      ContentLoaded := true;

      // Initialize variables now content has been loaded
      InitializeVariables();
    end;
end;

end.
