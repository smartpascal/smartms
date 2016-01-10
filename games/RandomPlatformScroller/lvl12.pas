unit lvl12;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  InDoor(750, 1050);
  OutDoor(1050, 500);
  FixPlats(1050, 500 + UE.HEIGHT, 50, 10);
  FixPlats(750, 1050 + UE.HEIGHT, 30 + UE.WIDTH, 10);
  SideScrollSize(2000, 2000);
  PercentofRands(45);
  PercentofNoFalls(70);
  PercentofJumpThoughs(30);
  PercentofCrumble(90);
  SpawnRands();
  StartLvl();
end;

end.