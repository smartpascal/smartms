unit lvl5;

interface

uses
  w3system, UE, UCreates;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('You can wall jump,  try it', 'blue', 10, 900);
  Text('on the walls in front to get to the top.', 'blue', 10, 920);
  Text('You can do this off any platform type', 'blue', 10, 940);
  Text("and it won't make crumbling platforms fall", 'blue', 10, 960);
  Text('You can also wall jump off one', 'blue', 500, 970);
  Text('wall repeatedly to climb it.', 'blue', 500, 990);
  Text('Do this by moving into it and jumping when touching the wall.', 'blue', 400, 1100);
  InDoor(10, 1000);
  OutDoor(700, 100);
  FixPlats(0, 1000 + UE.HEIGHT, 800, 10);
  FixPlats(0, 100 + UE.HEIGHT, 700 + UE.WIDTH, 10);
  FixPlats(300, 250, 10, 750);
  FixPlats(350, 250, 10, 750 + UE.HEIGHT);
  FixPlats(350, 250, 200, 10);
  FixPlats(700 + UE.WIDTH, 100 + UE.HEIGHT, 10, 850 - UE.HEIGHT);
  SideScrollSize(900,  1200);
  StartLvl();
end;

end.