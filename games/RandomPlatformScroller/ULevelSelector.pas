unit ULevelSelector;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system, UE, UPlat, UGameText, UPlayer, UAi, KeyCodeToKeyName, UGlobalsNoUserTypes;

type
  TSelect = class(TObject)
    screenwidth : integer; //The width of the selector
    screenheight : integer; //The height of the selector
    Doors : array of UE.TE; //An array of the possible level doors
    Plats : array of UPlat.TPlat; //Array of platforms so you can walk to doors
    Text : array of UGameText.TText; //array of text (instructions)
    Ai : array of TAi; //So that the game doesn't get confused as it needs the ai array
    maxX : integer; //The maxX (for the player update methods)
    maxY : integer; //The maxY (for the player update methods)
    constructor create();
    function selected(x1, y1, x2, y2 : float) : integer;
  end;

const
  //This is the amount of doors that spawn on the level selector.
  //It is reduced by 1 so it starts at the 0 index properly.
  DOORSAMOUNT = 18 - 1;

implementation

constructor TSelect.create();
var
  x, y, n, i, ii: integer; //Iteration variables, but x and y are for spawning of doors
  iidone : boolean; //iteration purposes
begin
  Text[0] := UGameText.TText.create('Use ' + CodeToKeyName(EnterKey) + ' to go through the door.', 'blue', 100, 60);
  Text[1] := UGameText.TText.create('Use ' + CodeToKeyName(LeftKey) + ' and ' + CodeToKeyName(RightKey) + ' to move left and right', 'blue', 100, 80);
  Text[2] := UGameText.TText.create('or you can use the buttons in the top and bottom left corners', 'blue', 100, 100);
  i := 0;
  ii := 0;
  iidone := False;
  x := 65;
  maxX := 965;
  y := 200 - UE.HEIGHT;
  n := 200;
  maxY := 200;
  while i <= DOORSAMOUNT do //Creates all the needed doors
    begin
      Doors[i] := UE.TE.create(x, y); //Spawns a new door
      if iidone = False then
        begin
          if n mod 400 = 0 then //Spawns platforms if new line of doors is created on new a line
            begin
              Plats[ii] := UPlat.TPlat.createF(50, y + UE.HEIGHT,maxX - 50, 10, True);
            end
          else //Spawns platforms if new line of doors is created on new a line
            begin
              Plats[ii] := UPlat.TPlat.createF(0,y + UE.HEIGHT,maxX - 50, 10, True);
            end;
          ii += 1;
          iidone := True;
        end;
      if i + 1 <= 9 then //Displays numbers on doors
        begin
          Text[i + 3] := UGameText.TText.create(IntToStr(i + 1), 'red',x +
                                                (UE.WIDTH div 2) - 5, y + (UE.HEIGHT div 4));
        end
      else //Displays numbers on doors
        begin
          Text[i + 3] := UGameText.TText.create(IntToStr(i + 1), 'red', x +
                                                (UE.WIDTH div 2) - 9, y + (UE.HEIGHT div 4));
        end;
      i += 1;
      if (n mod 400 = 0) and (n <> 200) then //Moves the x co-ord
        begin                                //if the platform is in an even row
          x -= 100; //Make the X of the door go left
          if x <= 49 then //If no more doors will be spawned after this one
            begin
              y += 200; //Increase it to the next row
              maxY += 200; //Increase the maxY for player purposes
              n += 200; //Increase it to the next row
              iidone := False;
            end;
        end
      else //Moves the x co-ord if the platform is a odd row
        begin
          x += 100; //Make the X of the door go right
          if x >= maxX then //If the door is over the maxX it wants to go down and left
            begin
              x -= 100; //Put the X of the door back on screen
              y += 200; //Increase it to the next row
              maxY += 200; //Increase the maxY for player purposes
              n += 200; //Increase it to the next row
              iidone := False;
            end;
        end;
    end;
  maxY += 100;
  Ai[0] := TAi.start();
  Ai[0].Dead := True;
end;

function TSelect.selected(x1, y1, x2, y2 : float) : integer;  //x2 = right hand side, x1 = left hand side
                                                             //y2 = bottom, y1 = top
var
  i : integer;
begin
  while i <= High(Doors) do //Iterates through the Doors
    begin
      if (y1 + y2 = Doors[i].y + UE.HEIGHT) then  //Checks if the bottoms are equal
        begin
          //Checks x overlap so if the door is selected properly
          if (x1 <= Doors[i].X + UE.WIDTH) and (x2 >= Doors[i].x) then
            begin
              Exit(i + 1); //Says the level that was selected, so the door + 1
                           //(as the door starts at 0, the levels start at 1)
            end;
        end;
      i += 1; //Adds one to i so that it selects the next door
    end;
  Exit(0); //No level was picked
end;

end.
