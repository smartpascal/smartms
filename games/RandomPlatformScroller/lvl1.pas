unit lvl1;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('Use ' + CodeToKeyName(LeftKey) + ' and ' + CodeToKeyName(RightKey) +
       ' to move left and right', 'blue', 10, 60);
  Text('Use ' + CodeToKeyName(EnterKey) + ' to go through the door', 'blue', 500, 60);
  Text('or you can use the buttons in the bottom left corner to move.', 'blue', 10, 80);
  Text('or the enter button in the top left corner.', 'blue', 500, 80);
  InDoor(10, 100);
  OutDoor(600, 100);
  FixPlats(10, 100 + UE.HEIGHT, 590 + UE.WIDTH, 10);
  SideScrollSize(800, 200);
  StartLvl(0);
end;

end.