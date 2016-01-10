unit lvl3;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('You are able to do one air jump.', 'blue', 90, 60);
  Text('_____', 'blue', 180, 200);
  Text('TIP: Jump here >>>', 'blue', 30, 200);
  InDoor(10, 100);
  OutDoor(450, 100);
  FixPlats(10, 100 + UE.HEIGHT,UE.WIDTH + 20, 10);
  FixPlats(280, 100 + UE.HEIGHT,UE.WIDTH + 170, 10);
  SideScrollSize(500, 500);
  PercentofRands(0);
  StartLvl(0);
end;

end.