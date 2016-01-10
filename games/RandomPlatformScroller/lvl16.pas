unit lvl16;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text("This is a turret. It will aim and shoot", "blue", 10, 80);
  Text("at you. Two shots will kill it!", "blue", 10, 100);
  Text("If it is on a crumbling platform, shoot the platform to make it fall with it.", "blue", 10, 120);
  InDoor(10, 150);
  OutDoor(600, 150);
  FixPlats(10, 150 + UE.HEIGHT, 590 + UE.WIDTH, 10);
  FixPlats(550, 50, 100, 10, false, false, false, false, false, 0, false, true);
  FixPlats(650, 50, 10, 100, false, false, true, false, false, 0, true, false);
  SideScrollSize(800, 300);
  StartLvl();
end;

end.