unit UAirUnit;

interface

uses
  W3System,
  UEnemy, UGameVariables, UTextures;

type TAirUnit = class(TEnemy)
  public
    MaxSpeed : float;
    YSpeed, YChanged, MaxYChange : float;
    MovingUp : boolean;
    constructor Create(newX, newY, newSpeed, newYChange : float; newHealth, newMoneyValue : integer);
    procedure Move(); override;
    function GetRect() : TRectF; override;
end;

implementation

constructor TAirUnit.Create(newX, newY, newSpeed, newYChange : float; newHealth, newMoneyValue : integer);
begin
  X := newX;
  Y := newY + newYChange / 2; // Makes the middle of bobbing at the y specified
  Speed := newSpeed;
  MaxSpeed := newSpeed;
  MaxHealth := newHealth;
  Health := newHealth;
  MoneyValue := newMoneyValue;
  YSpeed := 0;
  MaxYChange := newYChange;
  YChanged := 0;
  MovingUp := true;
  ApplyToEventHandler();
end;

procedure TAirUnit.Move();
begin
  inherited();
  Y += YSpeed;

  // Increase the speed if it is not moving at its max speed
  if Speed < MaxSpeed then
    begin
      Speed += FLYING_SPEED_CHANGE * 3;
    end;

  if MovingUp then
    begin
      // Increase the speed of moving up if it has not reached the max yet
      if -YSpeed < FLYING_SPEED_MAX then
        begin
          YSpeed -= FLYING_SPEED_CHANGE;
        end;

      if -YChanged > MaxYChange then
        begin
          // If it has moved its max, start going down again
          MovingUp := false;
        end
      else
        begin
          // Keep track on how much it has moved up
          YChanged += YSpeed;
        end;
    end
  else
    begin
      // Increase the speed of moving down if it has not reached the max yet
      if YSpeed < FLYING_SPEED_MAX then
        begin
          YSpeed += FLYING_SPEED_CHANGE;
        end;

      if YChanged > MaxYChange then
        begin
          // If it has moved its max, start going up again
          MovingUp := true;
        end
      else
        begin
          // Keep track on how much it has moved down
          YChanged += YSpeed;
        end;
    end;
end;

function TAirUnit.GetRect() : TRectF;
begin
  exit(TRectF.Create(X, Y, X + AirUnitTexture.Handle.width, Y + AirUnitTexture.Handle.height));
end;

end.
