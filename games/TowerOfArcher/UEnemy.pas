unit UEnemy;

interface

uses 
  W3System, W3Time,
  UGameVariables;

type ECrossedTowerEvent = procedure();

type TEnemy = class(TObject)
  public
    X, Y, Speed : float;
    Health, MaxHealth, MoneyValue : integer;
    Frozen, Dead : boolean;
    procedure Move(); virtual;
    function GetRect() : TRectF; virtual; abstract;
    procedure Hit(damage : integer; xArrowSpeed, yArrowSpeed : float);
    procedure Freeze(minDuration, maxDuration : integer);
    procedure PauseTimer();
    procedure ResumeTimer();
  protected
    Timer : TW3EventRepeater; // Timer for being frozen
    DelayHolder : integer;
    HasCrossedTower : boolean; // Whether the enemy has taken a life from the player by crossing the tower
    CrossedTowerEvent : ECrossedTowerEvent; // The event
    property OnPurchase : ECrossedTowerEvent read CrossedTowerEvent write CrossedTowerEvent; // The event handler
    procedure CrossedTower();
    procedure ApplyToEventHandler();
    function HandleTimer(sender : TObject) : boolean;
end;

procedure CrossedTowerEventHandler();

implementation

procedure TEnemy.Move();
begin
  // Move the enemy closer to the tower
  X -= Speed;

  // After the enemy has crossed the tower
  if X < 0 then
    begin
      // Take a life if it has not already done so
      if not HasCrossedTower then
        begin
          CrossedTower();
        end
      else
        begin
          // Kill the enemy if it's gone far beyond the end of the screen
          if X < -300 then
            begin
              Health := 0;
            end;
        end;
    end;
end;

procedure TEnemy.Hit(damage : integer; xArrowSpeed, yArrowSpeed : float);
begin
  // Multiply the speed of the arrow by the damage multiplier
  var damageWithSpeed := damage * Sqrt(Sqr(xArrowSpeed) + Sqr(yArrowSpeed));

  // Take the damage from the health
  Health -= Round(damageWithSpeed);

  if Health < 0 then
    begin
      Dead := true;
      Money += MoneyValue;
    end;
end;

procedure TEnemy.Freeze(minDuration, maxDuration : integer);
var
  duration : integer;
begin
  // Get a random duration from the range
  duration := RandomInt(maxDuration - minDuration) + minDuration;

  // Tell the enemy that it is frozen
  Frozen := true;

  // Set the timer
  Timer := TW3EventRepeater.Create(HandleTimer, duration);
end;

procedure TEnemy.PauseTimer();
begin
  // Try block to avoid issue with timer not being initialized before
  try
    // Store the delay then destroy the timer
    DelayHolder := Timer.Delay;
    Timer.Destroy();
  except
    on e: exception do;
  end;
end;

procedure TEnemy.ResumeTimer();
begin
  // Start the timer then reset the delay holder
  Timer := TW3EventRepeater.Create(HandleTimer, DelayHolder);
  DelayHolder := 0;
end;

procedure TEnemy.CrossedTower();
begin
  // Only run the handler if the event has one
  if Assigned(CrossedTowerEvent) then
    begin
      CrossedTowerEvent();
      HasCrossedTower := true;
    end;
end;

procedure TEnemy.ApplyToEventHandler();
begin
  CrossedTowerEvent := CrossedTowerEventHandler;
end;

function TEnemy.HandleTimer(sender : TObject) : boolean;
begin
  Frozen := false;
  TW3EventRepeater(sender).Free();
  exit(true);
end;

procedure CrossedTowerEventHandler();
begin
  Dec(Lives);
end;

end.