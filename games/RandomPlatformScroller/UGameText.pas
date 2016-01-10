unit UGameText;
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
  TText = class(TObject)
    text, colour : string;
    x, y : integer;
    constructor create(newText, newColour : string; newX, newY : integer);
  end;

implementation

constructor TText.create(newText, newColour : string; newX, newY : integer);
begin
  text := newText;
  x := newX;
  y := newY;
  colour := newColour;
end;

end.
