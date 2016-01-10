unit UCreates;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system, UE, UPlat, UGameText, UGlobals, UTurret, UGlobalsNoUserTypes;

  //These are spawning procedures. Call them in order that they are listed here
  //and it will make it easy to create a level.
  procedure ClearVARS();
  procedure Text(text, colour : string; x, y : integer);
  procedure InDoor(x, y : integer);
  procedure OutDoor(x, y : integer);
  procedure FixPlats(x, y, width, height : integer; JumpThroughorNoWallJump, NoFall, crumble, move, moveUp : boolean = false;
                     HowMuchMovement : integer = 200; onLeftOrTop, onRightOrBottom : boolean = false);
  procedure SpawnTurret(x, y, angle : float; placementSide : SidePlacedOn);
  procedure SideScrollSize(x, y : integer);
  procedure PercentofRands(percent : float);
  procedure PercentofVerticals(percent : float);
  procedure PercentofNoFalls(percent : float);
  procedure PercentofNoWallJumps(percent : float);
  procedure PercentofJumpThoughs(percent : float);
  procedure PercentofCrumble(percent : float);
  procedure PercentofMovings(percent : float);
  procedure PercentofMovesThatMoveX(percent : float);
  procedure MaxMoveForMoves(MaxMove : integer);
  procedure PercentofTurretsOnLeftorTop(percent : float);
  procedure PercentofTurretsOnRightorBottom(percent : float);
  procedure SpawnRands();
  procedure StartLvl(AmountOfAi : integer = 0);

implementation

procedure ClearVARS();
begin
  Ai.Clear();
  FPlats.Clear();
  RandPlats.Clear();
  Bullets.Clear();
  gameText.Clear();
  Turrets.Clear();
  maxX := 0;
  maxY := 0;
  offsetX := 0;
  offsetY := 0;
  RANDOMPLATFORMS := 0;
  RANDOMVERTICALPLATFORMS := 0;
  RANDOMJUMPTHROUGHPLATFORMS := 0;
  RANDOMNOFALLPLATFORMS := 0;
  RANDOMNOWALLJUMPPLATFORMS := 0;
  RANDOMCRUMBLEPLATFORMS := 0;
  RANDOMMOVINGPLATFORMS := 0;
  RANDOMMOVINGRIGHTTOLEFT := 50;
  RANDOMMAXMOVE := 0;
  RANDOMTURRETLEFTTOP := 0;
  RANDOMTURRETRIGHTBOTTOM := 0;
  Bullets[0] := UBullet.TBullet.create(True, -1000, -1000, 0, 0);
end;

procedure Text(text, colour : string; x, y : integer);
var
  i : integer;
begin
  i := High(UGlobals.gameText) + 1;
  UGlobals.gameText[i] := UGameText.TText.create(text, colour, x, y);
end;

procedure InDoor(x, y : integer);
begin
  UGlobals.EntranceDoor := UE.TE.create(x, y);
end;

procedure OutDoor(x, y : integer);
begin
  UGlobals.ExitDoor := UE.TE.create(x, y);
end;

procedure FixPlats(x, y, width, height : integer; JumpThroughorNoWallJump, NoFall, crumble, move, moveUp : boolean = false;
                   HowMuchMovement : integer = 200; onLeftOrTop, onRightOrBottom : boolean = false);
var
  i : integer;
begin
  i := High(UGlobals.FPlats) + 1;
  UGlobals.FPlats[i] := UPlat.TPlat.createF(x, y, width, height, JumpThroughorNoWallJump, NoFall, crumble,
                                            move, moveUp, HowMuchMovement, onLeftOrTop, onRightOrBottom);

  if FPlats[i].turretOnLeftOrTop then //Spawns a turret on the top or left side if told to
    begin
      if FPlats[i].horizontal then //Spawn a turret on top if it is horizontal
        begin
          SpawnTurret(FPlats[i].X, FPlats[i].Y, 0, Bottom);
          Turrets[High(Turrets)].isRand := false; //Record what platform the turret is on
          Turrets[High(Turrets)].PlatID := i; //Record what platform the turret is on
        end
      else //Spawn a turret on the left if it is vertical
        begin
          SpawnTurret(FPlats[i].X, FPlats[i].Y, 270, SidePlacedOn.Left);
          Turrets[High(Turrets)].isRand := false; //Record what platform the turret is on
          Turrets[High(Turrets)].PlatID := i; //Record what platform the turret is on
        end;
    end;
  if FPlats[i].turretOnRightOrBottom then //Spawn a turret on the bottom or right if told to
    begin
      if FPlats[i].horizontal then //Spawn a turret on the bottom if its is horizontal
        begin
          SpawnTurret(FPlats[i].X, FPlats[i].Y, 180, Top);
          Turrets[High(Turrets)].isRand := false; //Record what platform the turret is on
          Turrets[High(Turrets)].PlatID := i; //Record what platform the turret is on
        end
      else //Spawn a turret on the right if it is vertical
        begin
          SpawnTurret(FPlats[i].X, FPlats[i].Y, 90, SidePlacedOn.Right);
          Turrets[High(Turrets)].isRand := false; //Record what platform the turret is on
          Turrets[High(Turrets)].PlatID := i; //Record what platform the turret is on
        end;
    end;
end;

procedure SpawnTurret(x, y, angle : float; placementSide : SidePlacedOn);
begin
  var i := High(Turrets) + 1;
  Turrets[i] := TTurret.Create(x, y, angle, placementSide);
end;

procedure SideScrollSize(x, y : integer);
begin
  UGlobalsNoUserTypes.maxX := x;
  UGlobalsNoUserTypes.maxY := y;
end;

procedure PercentofRands(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  UGlobalsNoUserTypes.RANDOMPLATFORMS := round(((UGlobalsNoUserTypes.maxX * UGlobalsNoUserTypes.maxY) / 100) * percent);
end;

procedure PercentofVerticals(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMVERTICALPLATFORMS := percent;
end;

procedure PercentofNoFalls(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMNOFALLPLATFORMS := percent;
end;

procedure PercentofCrumble(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMCRUMBLEPLATFORMS := percent;
end;

procedure PercentofJumpThoughs(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMJUMPTHROUGHPLATFORMS := percent;
end;

procedure PercentofNoWallJumps(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMNOWALLJUMPPLATFORMS := percent;
end;

procedure PercentofMovings(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMMOVINGPLATFORMS := percent;
end;

procedure PercentofMovesThatMoveX(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMMOVINGRIGHTTOLEFT := percent;
end;

procedure MaxMoveForMoves(MaxMove : integer);
begin
  RANDOMMAXMOVE := MaxMove;
end;

procedure PercentofTurretsOnLeftorTop(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMTURRETLEFTTOP := percent;
end;

procedure PercentofTurretsOnRightorBottom(percent : float);
begin
  while percent > 100 do
    begin
      percent -= 100;
    end;
  RANDOMTURRETRIGHTBOTTOM := percent;
end;

procedure SpawnRands();
var
  i : float;
  n : integer;
begin
  i := 0;
  n := 0;
  while i < RANDOMPLATFORMS do
    begin
      RandPlats[n] := TPlat.CreateR(maxX, maxY, 10, 100, EntranceDoor, ExitDoor, FPlats,RandPlats, RANDOMVERTICALPLATFORMS,
                                    RANDOMJUMPTHROUGHPLATFORMS, RANDOMNOFALLPLATFORMS, RANDOMNOWALLJUMPPLATFORMS,
                                    RANDOMCRUMBLEPLATFORMS, RANDOMMOVINGPLATFORMS, RANDOMMOVINGRIGHTTOLEFT,
                                    RANDOMMAXMOVE, RANDOMTURRETLEFTTOP, RANDOMTURRETRIGHTBOTTOM);

      if RandPlats[n].turretOnLeftOrTop then //Spawns a turret on the top or left side if told to
        begin
          if RandPlats[n].horizontal then //Spawn a turret on top if it is horizontal
            begin
              SpawnTurret(RandPlats[n].X, RandPlats[n].Y, 0, Bottom);
              Turrets[High(Turrets)].isRand := true; //Record what platform the turret is on
              Turrets[High(Turrets)].PlatID := n; //Record what platform the turret is on
            end
          else //Spawn a turret on the left if it is vertical
            begin
              SpawnTurret(RandPlats[n].X, RandPlats[n].Y, 270, SidePlacedOn.Left);
              Turrets[High(Turrets)].isRand := true; //Record what platform the turret is on
              Turrets[High(Turrets)].PlatID := n; //Record what platform the turret is on
            end;
        end;
      if RandPlats[n].turretOnRightOrBottom then //Spawn a turret on the bottom or right if told to
        begin
          if RandPlats[n].horizontal then //Spawn a turret on the bottom if its is horizontal
            begin
              SpawnTurret(RandPlats[n].X, RandPlats[n].Y, 180, Top);
              Turrets[High(Turrets)].isRand := true; //Record what platform the turret is on
              Turrets[High(Turrets)].PlatID := n; //Record what platform the turret is on
            end
          else //Spawn a turret on the right if it is vertical
            begin
              SpawnTurret(RandPlats[n].X, RandPlats[n].Y, 90, SidePlacedOn.Right);
              Turrets[High(Turrets)].isRand := true; //Record what platform the turret is on
              Turrets[High(Turrets)].PlatID := n; //Record what platform the turret is on
            end;
        end;

      i += round(RandPlats[n].Width * RandPlats[n].Height); //Increase the area the platform has used with the area of the new platform
      n += 1;
    end;
end;

procedure StartLvl(AmountOfAi : integer = 0);
var
  i : integer;
begin
  Player.create(((UE.WIDTH - UPlayer.PLAYERHEAD) / 2) + EntranceDoor.X,
                  EntranceDoor.Y + UE.HEIGHT - UPlayer.PLAYERHEIGHT,
                  'red', PLAYERHEALTH, FPlats, RandPlats);
  i := 0;
  while i < AmountOfAi do
    begin
      Ai[i] := UAi.TAi.start();
      Ai[i].create(((UE.WIDTH - UPlayer.PLAYERHEAD) / 2) + ExitDoor.X, ExitDoor.Y +
                     UE.HEIGHT - UPlayer.PLAYERHEIGHT, 'blue', AIHEALTH, FPlats, RandPlats);
      Ai[i].TargRunBefore := false;
      Ai[i].TargRand1 := false;
      Ai[i].TargID1 := 0;
      Ai[i].PlayerInfo(Player, FPlats, RandPlats, maxX);
      Ai[i].OnPlatform(FPlats, RandPlats);
      Ai[i].WorkOutJumpTargs(1, FPlats, RandPlats, Player.X, Player.Y);
      Ai[i].update(maxX, AIHEALTH);
      Ai[i].isGrounded(maxY,FPlats,RandPlats);
      Ai[i].updateShoot();
      i += 1;
    end;
  AIS := AmountOfAi;
  UGlobalsNoUserTypes.maxY += 1000; //Adds 1000 to the maxY so you can see you fell off the map
end;

end.
