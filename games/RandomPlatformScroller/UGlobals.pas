unit UGlobals;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
//Variables of user made types e.g. the door which uses the TE type.
//This is hard to reference as units with types in are referenced by this unit.
interface

uses
  w3system, UPlat, UGameText, UE, UPlayer, UBullet, UAi, UTurret, ULevelSelector, UOptionsButton, UGlobalsNoUserTypes;

//All arrays here are dynamic, so they can be as big or small as they like
//and can change size at will.
var
  Player : TPlayer; //The player
  Ai : array of TAi; //the array of Ai Units
  EntranceDoor : TE; //The entrance Door
  ExitDoor : TE; //The Exit door
  FPlats : array of TPlat; //The array of Fixed Plats
  RandPlats : array of TPlat; //The array of random Plats
  Bullets : array of TBullet; //The array of bullets
  gameText : array of TText; //The array of Game Text
  Options : array of TOptionsButton; //An array of the option buttons
  ControlButtons : array of TOptionsButton; //An array of buttons that will move the player
                                            //This is the mobile support as it can be click
  Controls : array of TText; //A list of the controls as text elements
  Turrets : array of TTurret; //The array of Turrets
  Selector : ULevelSelector.TSelect; //The level selector

implementation

end.
