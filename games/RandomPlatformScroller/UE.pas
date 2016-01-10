unit UE;      //E = Exit/Entrance
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  w3system;

type
  TE = class(TObject)
    X, Y : integer;
    Won : boolean;
    constructor create(newX, newY : integer);
    //Checks if the player is over the door, so it has won
    function isDone(Cord1, Cord3, Cord4 : float) : boolean;
  end;

const
  HEIGHT = 60;
  WIDTH = 30;

implementation

constructor TE.create(newX, newY : integer);
begin
  X := newX;
  Y := newY;
end;

function TE.isDone(cord1, cord3, cord4 : float) : boolean;
begin
  if (cord1 <= X + WIDTH) and (cord3 >= X) and (cord4 = Y + HEIGHT) then
    begin
      Exit(true);
    end
  else
    begin
      Exit(false);
    end;
end;

end.
