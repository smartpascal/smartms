unit lvl13;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  InDoor(50, 50);
  OutDoor(1050, 1500);
  FixPlats(50, 50 + UE.HEIGHT, 50, 10);
  FixPlats(1050 - 10, 1500 + UE.HEIGHT, 20 + UE.WIDTH, 10);
  SideScrollSize(2000, 2000);
  PercentofRands(60);
  PercentofNoFalls(20);
  PercentofJumpThoughs(20);
  PercentofMovings(55);
  PercentofMovesThatMoveX(30);
  MaxMoveForMoves(500);
  SpawnRands();
  StartLvl();
end;

end.