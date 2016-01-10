unit UGroundUnit;

interface

uses 
  W3System,
  UEnemy, UTextures;

type TGroundUnit = class(TEnemy)
  public
    constructor Create(newX, newY, newSpeed : float; newHealth, newMoneyValue : integer);
    function GetRect() : TRectF; override;
end;

implementation

constructor TGroundUnit.Create(newX, newY, newSpeed : float; newHealth, newMoneyValue : integer);
begin
  X := newX;
  Y := newY;
  Speed := newSpeed;
  Health := newHealth;
  MaxHealth := newHealth;
  MoneyValue := newMoneyValue;
  ApplyToEventHandler();
end;

function TGroundUnit.GetRect() : TRectF;
begin
  exit(TRectF.Create(X, Y, X + GroundUnitTexture.Handle.width, Y + GroundUnitTexture.Handle.height));
end;

end.
