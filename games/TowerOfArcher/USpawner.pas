unit USpawner;

interface

uses 
  W3Time,
  UArrow, UGroundUnit, UAirUnit, UGameVariables, UGameItems, UScalingInfo, UTextures;

procedure SpawnArrow(xVol, yVol, x, y : float);
procedure StartGroundTimer(delay : integer);
procedure StartAirTimer(delay : integer);
procedure StartEnemySpawners();
procedure PauseEnemySpawners();
procedure SpawnGroundUnit();
procedure SpawnAirUnit();
procedure IncreaseDifficulty();
function HandleGroundTimer(sender : TObject) : boolean;
function HandleAirTimer(sender : TObject) : boolean;
function GetNextEnemyIndex() : integer;

var
  GroundTimer, AirTimer : TW3EventRepeater; // Timers for enemy spawn
  GroundDelay, AirDelay, GroundDelayHolder, AirDelayHolder : integer; // Dealys and delay holders for the timers
  Difficulty : integer; // The difficulty level

implementation

procedure SpawnArrow(xVol, yVol, x, y : float);
begin
  // Change the x and y velocity if they exceed the max power
  if (Sqrt(Sqr(xVol) + Sqr(yVol)) > MaxPower) then
    begin
      // Work out the angle
      var ang := ArcTan2(yVol, xVol);

      // Change the velocities to match the angle at max power
      xVol := Cos(ang) * MaxPower;
      yVol := Sin(ang) * MaxPower;
    end;

  for var i := 0 to High(Arrows) do
    begin
      // If the arrow is inactive spawn one at this index
      if not Arrows[i].Active then
        begin
          Arrows[i] := TArrow.Create(x, y, xVol, yVol);
          exit;
        end;
    end;

  // Spawn an arrow if an inactive one wasn't found
  Arrows[High(Arrows) + 1] := TArrow.Create(x, y, xVol, yVol);
end;

procedure StartGroundTimer(delay : integer);
begin
  GroundTimer := TW3EventRepeater.Create(HandleGroundTimer, delay);
end;

procedure StartAirTimer(delay : integer);
begin
  AirTimer := TW3EventRepeater.Create(HandleAirTimer, delay);
end;

procedure StartEnemySpawners();
begin
  // Start the ground timer
  if GroundDelayHolder <= 0 then
    begin
      StartGroundTimer(GroundDelay);
    end
  else
    begin
      StartGroundTimer(GroundDelayHolder);
    end;

  // Start the air timer
  if AirDelayHolder <= 0 then
    begin
      StartAirTimer(AirDelay);
    end
  else
    begin
      StartAirTimer(AirDelayHolder);
    end;

  // Clear delay holders
  GroundDelayHolder := 0;
  AirDelayHolder := 0;
end;

procedure PauseEnemySpawners();
begin
  // Record the delays
  GroundDelayHolder := GroundTimer.Delay;
  AirDelayHolder := AirTimer.Delay;

  // Destroy the timers
  GroundTimer.Destroy();
  AirTimer.Destroy();
end;

procedure SpawnGroundUnit();
var
  speed : float;
  health : integer;
  moneyVal : integer;
begin
  // Get a random speed
  speed := RandomInt(3500) / 1000; // Max speed is 3.5

  // Make the health multiplied by the speed equal the difficulty
  health := Round(Difficulty / speed);

  // Generate a money value
  moneyVal := (Difficulty div 25 + RandomInt(Difficulty div 25)) div 2;

  // Spawn the enemy
  Enemies[GetNextEnemyIndex()] := TGroundUnit.Create(GAMEWIDTH, GAMEHEIGHT - GroundUnitTexture.Handle.height, speed, health, moneyVal);

  // Increase the difficulty
  IncreaseDifficulty();
end;

procedure SpawnAirUnit();
var
  speed : float;
  yChange, y, health : integer;
  moneyVal : integer;
begin
  // Get the y change
  yChange := RandomInt(GAMEHEIGHT div 4);

  // Generate a starting y position from the y change
  y := RandomInt(GAMEHEIGHT - yChange * 2 - AirUnitTexture.Handle.height * 2) + yChange;

  // Get speed and make health indirectly proportionate to the speed
  speed := RandomInt(3500) / 1000; // Max speed is 3.5
  health := Round((Difficulty - yChange) / speed);

  // Generate a money value
  moneyVal := (Difficulty div 33 + RandomInt(Difficulty div 33)) div 2;

  // Spawn the flying enemy
  Enemies[GetNextEnemyIndex()] := TAirUnit.Create(GAMEWIDTH, y, speed, yChange, health, moneyVal);

  // Increase the difficulty
  IncreaseDifficulty();
end;

procedure IncreaseDifficulty();
begin
  Difficulty += 150;
end;

function HandleGroundTimer(sender : TObject) : boolean;
begin
  SpawnGroundUnit();

  // Release the timer then restart it
  TW3EventRepeater(sender).Free();
  StartGroundTimer(RandomInt(GroundDelay) + GroundDelay);
  exit(true);
end;

function HandleAirTimer(sender : TObject) : boolean;
begin
  SpawnAirUnit();

  // Release the timer then restart it
  TW3EventRepeater(sender).Free();
  StartAirTimer(RandomInt(AirDelay) + AirDelay);
  exit(true);
end;

function GetNextEnemyIndex() : integer;
begin
  // Check for dead enemies
  for var i := 0 to High(Enemies) do
    begin
      if Enemies[i].Dead then
        begin
          exit(i); // Return the first index of a dead enemy
        end;
    end;

  // If no dead enemies were found create a new index
  exit(Length(Enemies));
end;

end.
