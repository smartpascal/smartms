unit UGameVariables;

interface

uses
  W3System;

const
  GRAVITY = 1.5;
  FLYING_SPEED_CHANGE = 0.1;
  FLYING_SPEED_MAX = 3;
  ARROW_FREEZE_DURATION_RANGE = 2000;

var
  MaxPower : float;
  ArrowDamage : integer;
  ArrowsFreeze : boolean;
  ArrowFreezeDuration : integer;
  TimeBetweenShots : integer;
  PauseButtonCoordinates : array [0 .. 3] of integer;
  RestartButtonCoordinates : array [0 .. 3] of integer;
  RestartClicked : boolean;
  Paused : boolean;
  Lives : integer;
  Money : integer;

function FloatMod(a, b : float) : integer; // A function to perform modulus operations on floats
function PauseButtonRect() : TRect;
function RestartButtonRect() : TRect;

implementation

function FloatMod(a, b : float) : integer;
begin
  exit(Trunc(a - b * Trunc(a / b)));
end;

function PauseButtonRect() : TRect;
begin
  exit(TRect.Create(PauseButtonCoordinates[0], PauseButtonCoordinates[1], PauseButtonCoordinates[2], PauseButtonCoordinates[3]));
end;

function RestartButtonRect() : TRect;
begin
  exit(TRect.Create(RestartButtonCoordinates[0], RestartButtonCoordinates[1], RestartButtonCoordinates[2], RestartButtonCoordinates[3]));
end;

end.