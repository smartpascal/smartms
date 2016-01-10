unit lvl6;

interface

uses
  w3system, UE, UCreates;

var
  i : float;
  n : integer;

procedure Initialize();

implementation

procedure Initialize();
begin
  ClearVARS();
  Text("There are 9 types", "blue", 10, 550);
  Text("of platform", "blue", 10, 570);
  Text("Go test and play on them", "blue", 150, 620);
  Text("TIP: Try things you know,  like falls and jumps", "blue", 170, 640);
  Text("Giveaways on what the platforms do are above", "blue", 650, 630);
  Text("^", "blue", 850, 610);
  Text("Giveaways on what the platforms do are right >>>", "blue", 550, 235);
  Text("Pink: Vertical and you can't fall through it or wall jump off it",  'rgba(250,  100,  190,  0.9)', 900, 160);
  Text("Purple: Vertical and you can fall through it,  but not wall jump off it",  'rgba(190,  10,  120,  0.9)', 900, 210);
  Text("Grey: Vertical and you can fall through it and wall jump off it", "rgb(100, 100, 100)", 900, 260);
  Text("Orange: Vertical and you can wall jump off it but can't fall through it", 'rgba(255, 80, 0, 0.9)', 900, 310);
  Text("Green: Horizontal and you can jump and fall through it", 'rgb(0, 50, 0)', 900, 360);
  Text("Black: Horizontal and you can't jump through it but can fall", 'rgb(0, 0, 0)', 900, 410);
  Text("Red: Horizontal and you can jump through it,  but not fall", 'rgb(100, 0, 0)', 900, 460);
  Text("Blue: Horizontal and you can't jump or fall through it", 'rgb(0, 0, 100)', 900, 510);
  Text("Brown: Can have any properties but will fall after you jump on it", 'rgb(90, 65, 35)', 900, 560);
  Text("NOTE: All horizontal platforms can be wall jumped off of and all vertical ones can't be jumped through",  'blue', 680, 110);
  InDoor(10, 600);
  OutDoor(1000, 600);
  FixPlats(0, 600 + UE.HEIGHT, 1400, 10);
  FixPlats(140, 250, 10, 300);
  FixPlats(200, 500, 200, 10, true);
  FixPlats(200, 300, 200, 10);
  FixPlats(450, 250, 10, 300, true);
  FixPlats(500, 250, 10, 300, true, true);
  FixPlats(375, 200, 200, 10);
  FixPlats(550, 500, 200, 10, true, true);
  FixPlats(550, 300, 200, 10, false, true);
  FixPlats(800, 250, 10, 300, false, true);
  FixPlats(880, 190, 10, 30, true);
  FixPlats(880, 140, 10, 30, true, true);
  FixPlats(880, 240, 10, 30);
  FixPlats(880, 290, 10, 30, false, true);
  FixPlats(1150, 370, 200, 10, true);
  FixPlats(850, 420, 200, 10);
  FixPlats(1150, 470, 200, 10, true, true);
  FixPlats(850, 520, 200, 10, false, true);
  FixPlats(1150, 570, 200, 10, false, false, true);
  SideScrollSize(1400, 900);
  PercentofRands(0);
  PercentofVerticals(0);
  PercentofNoFalls(0);
  PercentofJumpThoughs(0);
  SpawnRands();
  StartLvl();
end;

end.