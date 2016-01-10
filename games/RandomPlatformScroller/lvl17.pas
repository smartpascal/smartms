unit lvl17;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  InDoor(10, 150);
  OutDoor(1350, 1300);
  FixPlats(0, 150 + UE.HEIGHT, UE.WIDTH + 20, 10);
  FixPlats(1340, 1300 + UE.HEIGHT, UE.WIDTH + 20, 10);
  SideScrollSize(1500, 1500);
  PercentofRands(75.391);
  PercentofVerticals(15);
  PercentofNoFalls(15);
  PercentofNoWallJumps(15);
  PercentofJumpThoughs(30);
  PercentofCrumble(20);
  PercentofMovings(5);
  PercentofMovesThatMoveX(50);
  MaxMoveForMoves(500);
  PercentofTurretsOnLeftorTop(0.55);
  PercentofTurretsOnRightorBottom(0.55);
  SpawnRands();
  StartLvl();
end;

end.