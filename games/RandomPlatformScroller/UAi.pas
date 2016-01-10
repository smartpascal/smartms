unit UAi;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system, UPlayer, UBullet, UPlat, UGlobalsNoUserTypes;

type TAi = class(UPlayer.TPlayer)
  OnPlat, OnRand : boolean;
  PlatID : integer;
  LOSXMin, LOSXMax, LOSYMin, LOSYMax : float; //LOS = Line Of Shot
  PX, PY : float; //P = Player
  TargRunBefore : boolean;
  TargRand1 : boolean;
  TargID1 : integer;
  procedure WorkOutMoves(player : UPlayer.TPlayer; Bullets : array of TBullet; FixedPlats, RandPlats : Array of TPlat; screenwidth, screenheight : integer);
  procedure WorkOutJumpTargs(TargNO : integer; FixedPlats, RandPlats : array of TPlat; X, Y : float);
  function CanJumpTo(FixedPlats, RandPlats : array of TPlat; X, Y : float; TargetID : integer; isTargetRand : boolean = true) : boolean;
  procedure PlayerInfo(player : TPlayer; FixedPlats, RandPlats : Array of TPlat; screenwidth : integer);
  function SimulateBullet(FixedPlats, RandPlats : array of TPlat; testLeft : boolean) : float;
  procedure OnPlatform(FixedPlats, RandPlats : Array of TPlat);
  procedure OnPlatform(FixedPlats, RandPlats : Array of TPlat; x, y : float); overload;
  procedure Shoot(Bullets : array of TBullet);
  procedure MoveOnPlat(targPlats, playerPlats : array of TPlat);
  procedure MoveInAir(targPlats : array of TPlat);
end;

implementation
var
LastX, LastY : float;
counter : integer;

procedure TAi.WorkOutMoves(player : UPlayer.TPlayer; Bullets : array of TBullet; FixedPlats, RandPlats : Array of TPlat; screenwidth, screenheight : integer);
begin

end;

procedure TAi.WorkOutJumpTargs(TargNO : integer; FixedPlats, RandPlats : array of TPlat; X, Y : float);
begin

end;

function TAi.CanJumpTo(FixedPlats, RandPlats : array of TPlat; X, Y : float; TargetID : integer; isTargetRand : boolean = true) : boolean;
begin

end;

procedure TAi.PlayerInfo(player : TPlayer; FixedPlats, RandPlats : Array of TPlat; screenwidth : integer);
begin

end;

function TAi.SimulateBullet(FixedPlats, RandPlats : array of TPlat; testLeft : boolean) : float;
begin

end;

procedure TAi.OnPlatform(FixedPlats, RandPlats : Array of TPlat);
begin

end;

procedure TAi.OnPlatform(FixedPlats, RandPlats : Array of TPlat; x, y : float);
begin

end;

procedure TAi.shoot(Bullets : array of TBullet);
begin

end;

procedure TAi.MoveOnPlat(targPlats, playerPlats : array of TPlat);
begin

end;

procedure TAi.MoveInAir(targPlats : array of TPlat);
begin

end;

end.
