unit Settings;
{
    Copyright (c) 2014 Josh Blake

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

const
  ENEMY_CREATION_SPEED = 0.07;     //start creation speed
  ENEMY_CREATION_MULTIPLIER = 1000;  //speed of increase

  BACKGROUND_COLOR = 'black';
  PLAYER_COLOR = 'blue';
  ENEMY_COLOR = 'red';
  BULLET_COLOR = 'white';

  ENEMY_SPEED = 3;
  PLAYER_SPEED = 2;
  BULLET_SPEED = 5;

  BULLET_INTERVAL = 0.00001;

  DEBUG = true;

procedure Log(aMessage: String);

implementation

procedure Log(aMessage: String);
begin
  if DEBUG then begin
    asm
      console.log((@aMessage));
    end;
  end;
end;

end.