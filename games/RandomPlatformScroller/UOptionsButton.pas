unit UOptionsButton;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System;

type
  TOptionsButton = class(TObject)
  X : float; //The x position of the button
  Y : float; //the y position of the button
  Width : float; //the width of the button
  Height : float; //the height of the button
  Text : string; //the text in the button
  TextX : float; //the X of the text in the button
  TextY : float; //the Y of the text in the button
  constructor create(newX, newY, newWidth, newHeight : float; newText : string; newTextX,newTextY : float);
   //If the x and y are in the button, it will return true as it has been clicked
  function clicked(clickX, clickY : float) : boolean;
end;

implementation

constructor TOptionsButton.create(newX,newY,newWidth,newHeight : float; newText : string; newTextX,newTextY : float);
begin
  X := newX;
  Y := newY;
  Width := newWidth;
  Height := newHeight;
  Text := newText;
  TextX := newTextX;
  TextY := newTextY;
end;

function TOptionsButton.clicked(clickX,clickY : float) : boolean;
begin
  if (clickX >= X) and (clickX <= X + Width) then //if the x is in the x range
    begin
      if (clickY >= Y) and (clickY <= Y + Height) then //if the y is in the y range
        begin
          Exit(true); //return true if both passed
        end;
    end;

  Exit(false); //otherwise return false
end;

end.
