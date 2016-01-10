unit lvl11;

interface
//Designed by Alex Karet.
//05/05/2014
//Find your way to the top, showcasing the jump through platforms.

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  InDoor(1050, 1050);
  OutDoor(50, 500);
  FixPlats(50, 500 + UE.HEIGHT, 50, 10);
  FixPlats(1050, 1050 + UE.HEIGHT, 30 + UE.WIDTH, 10);
  SideScrollSize(1500, 1500);
  PercentofRands(45);
  PercentofNoFalls(20);
  PercentofJumpThoughs(70);//high percent in order to showcase the platforms
  SpawnRands();
  StartLvl();
end;

end.