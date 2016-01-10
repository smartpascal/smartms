unit lvl7;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text('Crumbling Platforms:',  'blue',  90,  70);
  Text('With speed you can jump from one to another', 'blue', 90, 180);
  Text('Crumbles can have any property so its always worth checking', 'blue', 1000, 550);
  Text('Use ' + CodeToKeyName(ShootKey) + ' to shoot stright', 'blue', 700, 40);
  Text('or you can aim with the mouse,  and click to shoot towards it', 'blue', 550, 80);
  Text('or you can click the shoot button on screen to shoot stright',  'blue',  625,  60);
  Text('Bullets will make crumble platforms fall', 'blue', 750, 100);
  InDoor(10,  30);
  OutDoor(610,  500 - UE.HEIGHT);
  FixPlats(0,  30 + UE.HEIGHT,  UE.WIDTH + 20,  10);
  FixPlats(150, 200, 100, 10, false, false, true);
  FixPlats(400, 200, 100, 10, false, false, true);
  FixPlats(650, 200, 100, 10, false, false, true);
  FixPlats(900, 200, 400, 10);
  FixPlats(600, 400, 500, 10, false, true);
  FixPlats(1100, 200, 10, 310);
  FixPlats(600, 400, 10, 110);
  FixPlats(600, 500, 350, 10, false, true);
  FixPlats(950, 500, 150, 10, true, false, true);
  FixPlats(1100, 0, 10, 510, false, true, true);
  FixPlats(800, 600, 800, 10, false, true);
  FixPlats(3000,  100 + UE.HEIGHT, 100 + UE.WIDTH,  10);
  SideScrollSize(4000, 1500);
  StartLvl();
end;

end.