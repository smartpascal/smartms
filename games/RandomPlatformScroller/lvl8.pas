unit lvl8;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('All Platforms can move.', 'blue', 90, 100);
  InDoor(50, 50);
  OutDoor(500, 100);
  FixPlats(40, 50 + UE.HEIGHT, UE.WIDTH + 10, 10);
  FixPlats(490, 100 + UE.HEIGHT, UE.WIDTH + 10, 10);
  FixPlats(150, 150, 150, 10, false, false, false, true, false, 300);
  FixPlats(150, 250, 150, 10, true, false, false, true, false, 300);
  FixPlats(150, 350, 150, 10, true, true, false, true, false, 300);
  FixPlats(150, 450, 150, 10, false, true, false, true, false, 300);
  FixPlats(600, 0, 10, 200, false, false, true, true, true, 400);
  FixPlats(150, 550, 150, 10, false, false, true, true, false, 300);
  SideScrollSize(700, 700);
  StartLvl();
end;

end.