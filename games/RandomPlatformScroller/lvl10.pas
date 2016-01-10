unit lvl10;

interface
//Designed by Alex Karet.
//05/05/2014
//Showcasing the non fall through platforms, Will probably require tutorial to explain this.

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('This game also scrolls up and down; try to find the door!', 'blue', 90, 70);
  Text('Note how you cannot fall through most of the platforms, maybe the door is downwards then?', 'black', 100, 90);
  InDoor(50, 50);
  OutDoor(100, 1030);
  FixPlats(50, 50 + UE.HEIGHT, 50, 10);
  FixPlats(100, 1030 + UE.HEIGHT, 30 + UE.WIDTH, 10);
  SideScrollSize(1200, 1500);
  PercentofRands(65);
  PercentofNoFalls(80);//High percent to showcase feature
  PercentofJumpThoughs(5);
  SpawnRands();
  StartLvl(0);
end;

end.