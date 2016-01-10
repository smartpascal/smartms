unit UGlobalsNoUserTypes;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
//This unit is for constants and variables that may be needed in several units,
//but this one doesn't reference any meaning all units can access this one

interface

uses
  W3System;

//This is the list of moving controls for the player, stored as a Enumerator
type
  MoveCommands = (right, left, null);

//The types of gamemodes or menus available
type
  GameModes = (maingame, levelselector, settings);

const
  PLAYERHEALTH = 45; //The health of the player
  AIHEALTH = 30; //The health of an AI Unit
  PLAYERHEAD = 15; //Player Width
  PLAYERHEIGHT = 45; //Player Height
  DEFAULT_HORIZONTAL_HEIGHT = 10; //The default horizontal height of a rand platform
  DEFAULT_VERTICAL_WIDTH = 10; //the default vertical width of a rand platform
  TURRET_WIDTH = 20;
  TURRET_HEIGHT = 30;

var
  UnlockedDoors : integer; //The amount of doors unlocked
  MouseX, MouseY : float; //The Mouse's X and Y co-ordinates
  screenWidth : float; //the width of the viewport
  screenHeight : float; //the height of the viewport
  gamemode : GameModes; //Holds what gamemode we are in
  maxX : integer; //The maximum X for a level
  maxY : integer; //The Maximum Y for a level
  AIS : integer; //The number of Ai Units
  offsetX : float; //The offset X to draw a element at
  offsetY : float; //The offset Y to draw a element at
  RANDOMPLATFORMS : float; //The percetage of the screen that will be random platforms
  RANDOMVERTICALPLATFORMS : float; //The percentage of platforms that will be vertical
  RANDOMJUMPTHROUGHPLATFORMS : float; //The percentage of platforms that you can jump through
  RANDOMNOFALLPLATFORMS : float; //The percentage of platforms that you cannot fall through
  RANDOMNOWALLJUMPPLATFORMS : float; //The percentage of platforms that you cannot wall jump off of
  RANDOMCRUMBLEPLATFORMS : float; //The percentage of platforms that will crumble
  RANDOMMOVINGPLATFORMS : float; //the percentage of platforms that will move
  RANDOMMOVINGRIGHTTOLEFT : float; //the percentage of moving platforms that will move left to right
  RANDOMMAXMOVE : integer; //the maximum move speed for moving platforms
  RANDOMTURRETLEFTTOP : float; //The percent of random platforms that will have a turret on the top or left side
  RANDOMTURRETRIGHTBOTTOM : float; //The percent of random platforms that will have a turret on the bottom or right side
  RightKey : integer; //The key code for the Move Right Key
  LeftKey : integer; //The key code for the Move Left Key
  JumpKey : integer; //The key code for the Jumping Key
  FallKey : integer; //The key code for the Fall Key
  ShootKey : integer; //The key code for the Shoot key
  EnterKey : integer; //The key code for the Enter Door Key
  EscapeKey : integer; //The key code for the Excape Key
  Level : integer; //The level we are on

implementation

end.
