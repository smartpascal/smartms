unit lvl2;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('Use ' + CodeToKeyName(JumpKey) + ' to jump', 'blue', 90, 60);
  Text('or the button labelled "Jump" in the bottom left corner.', 'blue', 10, 80);
  InDoor(10, 100);
  OutDoor(300, 100);
  FixPlats(10, 100 + UE.HEIGHT, 100, 10);
  FixPlats(200, 100 + UE.HEIGHT, 100 + UE.WIDTH, 10);
  SideScrollSize(500, 500);
  PercentofRands(0);
  StartLvl(0);
end;

end.