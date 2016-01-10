unit lvl15;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text("Now try without wall jumps!", "blue", 750, 1260);
  InDoor(750, 1300);
  OutDoor(100, 200);
  FixPlats(750, 1300 + UE.HEIGHT, 50, 10);
  FixPlats(100, 200 + UE.HEIGHT, 30 + UE.WIDTH, 10);
  SideScrollSize(1500, 1500);
  PercentofRands(55);
  PercentofVerticals(50);
  PercentofNoFalls(70);
  PercentofJumpThoughs(30);
  PercentofCrumble(40);
  PercentofNoWallJumps(100);
  SpawnRands();
  StartLvl();
end;

end.