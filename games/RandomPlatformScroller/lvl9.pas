unit lvl9;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('Enjoy the sidescrolling!', 'blue', 90, 500);
  InDoor(10, 500);
  OutDoor(3000, 500);
  FixPlats(0 ,500 + UE.HEIGHT, 4000, 10);
  FixPlats(3000, 100 + UE.HEIGHT, 100 + UE.WIDTH, 10);
  SideScrollSize(4000, 700);
  PercentofRands(3.1);
  PercentofVerticals(10);
  PercentofNoFalls(30);
  PercentofJumpThoughs(30);
  PercentofCrumble(20);
  PercentofMovings(10);
  PercentofMovesThatMoveX(70);
  MaxMoveForMoves(500);
  SpawnRands();
  StartLvl(0);
end;

end.