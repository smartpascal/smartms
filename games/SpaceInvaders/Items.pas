unit Items;
{
    Copyright (c) 2014 Josh Blake

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  SmartCL.Graphics, Settings, Input;

type
  TCollisionResult = (Nothing, DeleteSelf, DeleteOther, GameOver);

  TItem = class(TObject)
  public
    x, y: Integer;
    constructor Create(aHeight, aWidth, StartX, StartY: Integer); virtual;
    procedure UpdatePosition; virtual; abstract;
    function CheckCollision(Item: TItem): Boolean;
    procedure Draw(Canvas: TW3Canvas);
    function Left: Integer;
    function Right: Integer;
    function Top: Integer;
    function Bottom: Integer;
    function IsOnScreen(Height: Integer): Boolean; virtual;
  protected
    height, width: Integer;
    function GetColor: String; virtual; abstract;
  end;

  TEnemy = class(TItem)
  public
    procedure UpdatePosition; override;
  protected
    function GetColor: String; override;
  end;

  TBullet = class(TItem)
  public
    procedure UpdatePosition; override;
  protected
    function GetColor: String; override;
  end;

  TPlayer = class(TItem)
  public
    XSpeed, YSpeed: Integer;
    constructor Create(aHeight, aWidth, StartX, StartY: Integer); override;
    procedure UpdatePosition; override;
    function IsOnScreen(Height: Integer): Boolean; override;
  protected
    function GetColor: String; override;
    procedure KeyDown(mCode: Integer);
    procedure KeyUp(mCode: Integer);
  end;

implementation

constructor TItem.Create(aHeight, aWidth, StartX, StartY: Integer);
begin
  height := aHeight;
  width := aWidth;
  X := StartX;
  Y := StartY;
end;

procedure TItem.Draw(Canvas: TW3Canvas);
begin
  Canvas.FillStyle := GetColor;
  Canvas.FillRectF(X, Y, Width, Height);
end;

function TItem.Left: Integer;
begin
  Result := X
end;

function TItem.Right: Integer;
begin
  Result := X + Width;
end;

function TItem.Top: Integer;
begin
  Result := Y;
end;

function TItem.Bottom: Integer;
begin
  Result := Y + Height
end;

function TItem.CheckCollision(Item: TItem): Boolean;
begin
  Result := (Left < Item.Right) and (Right > Item.Left) and
            (Top < Item.Bottom) and (Bottom > Item.Top)
end;

function TItem.IsOnScreen(Height: Integer): Boolean;
begin
  if (Bottom < 0) or (Top > Height) then begin
    Log('Item off screen');
    Result := False;
  end else Result := True;
end;

procedure TEnemy.UpdatePosition;
begin
  Y := Y + ENEMY_SPEED;
end;

function TEnemy.GetColor: String;
begin
  Result := ENEMY_COLOR;
end;

procedure TBullet.UpdatePosition;
begin
  Y := Y - BULLET_SPEED;
end;

function TBullet.GetColor: String;
begin
  Result := BULLET_COLOR;
end;

constructor TPlayer.Create(aHeight, aWidth, StartX, StartY: Integer);
begin
  inherited(aHeight, aWidth, StartX, StartY);
  AddKeyDown(KeyDown);
  AddKeyUp(KeyUp);
end;

procedure TPlayer.KeyDown(mCode: Integer);
begin
  case mcode of
    37: XSpeed := -PLAYER_SPEED;   //left arrow
    38: YSpeed := -PLAYER_SPEED;   //up arrow
    39: XSpeed := PLAYER_SPEED;    //right arrow
    40: YSpeed := PLAYER_SPEED;    //down arrow
  end;
end;

procedure TPlayer.KeyUp(mCode: Integer);
begin
  if (mCode = 37) or (mCode = 39) then XSpeed := 0;
  if (mCode = 38) or (mCode = 40) then YSpeed := 0;
end;

procedure TPlayer.UpdatePosition;
begin
  X := X + XSpeed;
  Y := Y + YSpeed;
end;

function TPlayer.GetColor: String;
begin
  Result := PLAYER_COLOR;
end;

function TPlayer.IsOnScreen(Height: Integer): Boolean;
begin
  Result := True;
end;

end.