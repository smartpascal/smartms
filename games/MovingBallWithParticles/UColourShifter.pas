unit UColourShifter;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  SmartCL.System;

type TColourShifter = class(TObject)
  Colour: array [0 .. 2] of integer;
  ColourToEdit: integer;
  IncrementColour: boolean;
  ShiftsLeft: float;
  constructor Create(newRed, newGreen, newBlue: integer);
  procedure ShiftColour(timesToShift : float = 1);
  function RGBString: string;
end;

implementation

constructor TColourShifter.Create(newRed, newGreen, newBlue : integer);
begin
  Colour[0] := newRed;
  Colour[1] := newGreen;
  Colour[2] := newBlue;
  ColourToEdit := 0;
  IncrementColour := true;
  ShiftsLeft := 0;
end;

procedure TColourShifter.ShiftColour(timesToShift : float = 1);
begin
  // Add the amount of shifts
  ShiftsLeft += timesToShift;
  // Do the correct amount of shifts
  while (ShiftsLeft > 0) do
    begin
      // Change the colour value
      if IncrementColour then
        inc(Colour[ColourToEdit])
      else
        dec(Colour[ColourToEdit]);
      // Change the column to change the colour
      if Colour[ColourToEdit] > 255 then
        begin
          dec(Colour[ColourToEdit]);
          inc(ColourToEdit);
        end
      else if Colour[ColourToEdit] < 0 then
        begin
          inc(Colour[ColourToEdit]);
          inc(ColourToEdit);
        end;
      // Make sure the colour to edit is within the bounds of the array
      if ColourToEdit = 3 then
        begin
          ColourToEdit := 0;
          IncrementColour := not IncrementColour;
        end;
      ShiftsLeft -= 1;
    end;
end;

function TColourShifter.RGBString: string;
begin
  var rgb : string;
  rgb := 'rgb(' + IntToStr(Colour[0]) + ', ' + IntToStr(Colour[1]) + ', ' + IntToStr(Colour[2]) + ')';
  exit(rgb);
end;

end.
