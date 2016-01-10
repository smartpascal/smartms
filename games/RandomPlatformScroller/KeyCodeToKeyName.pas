unit KeyCodeToKeyName;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System;

function CodeToKeyName(KeyCode : integer) : string;

implementation

//Used to get key name from a key code, meaning it will show you your controls
//with proper key names, not just the numbered key codes
function CodeToKeyName(KeyCode : integer) : string;
begin
  case KeyCode of
    8 : Exit("Backspace");
    9 : Exit("Tab");
    13 : Exit("Enter");
    16 : Exit("Shift");
    17 : Exit("Ctrl");
    18 : Exit("Alt");
    19 : Exit("Pause/Break");
    20 : Exit("Caps Lock");
    27 : Exit("Escape");
    32 : Exit("Space");
    33 : Exit("Page Up");
    34 : Exit("Page Down");
    35 : Exit("End");
    36 : Exit("Home");
    37 : Exit("Left Arrow");
    38 : Exit("Up Arrow");
    39 : Exit("Right Arrow");
    40 : Exit("Down Arrow");
    45 : Exit("Insert");
    46 : Exit("Delete");
    48 : Exit("0");
    49 : Exit("1");
    50 : Exit("2");
    51 : Exit("3");
    52 : Exit("4");
    53 : Exit("5");
    54 : Exit("6");
    55 : Exit("7");
    56 : Exit("8");
    57 : Exit("9");
    65 : Exit("A");
    66 : Exit("B");
    67 : Exit("C");
    68 : Exit("D");
    69 : Exit("E");
    70 : Exit("F");
    71 : Exit("G");
    72 : Exit("H");
    73 : Exit("I");
    74 : Exit("J");
    75 : Exit("K");
    76 : Exit("L");
    77 : Exit("M");
    78 : Exit("N");
    79 : Exit("O");
    80 : Exit("P");
    81 : Exit("Q");
    82 : Exit("R");
    83 : Exit("S");
    84 : Exit("T");
    85 : Exit("U");
    86 : Exit("V");
    87 : Exit("W");
    88 : Exit("X");
    89 : Exit("Y");
    90 : Exit("Z");
    91 : Exit("Left Window Key");
    92 : Exit("Right Window Key");
    93 : Exit("Select Key");
    96 : Exit("Numpad 0");
    97 : Exit("Numpad 1");
    98 : Exit("Numpad 2");
    99 : Exit("Numpad 3");
    100 : Exit("Numpad 4");
    101 : Exit("Numpad 5");
    102 : Exit("Numpad 6");
    103 : Exit("Numpad 7");
    104 : Exit("Numpad 8");
    105 : Exit("Numpad 9");
    106 : Exit("Multiply");
    107 : Exit("Add");
    109 : Exit("Subtract");
    110 : Exit("Decimal Point");
    111 : Exit("Divide");
    112 : Exit("F1");
    113 : Exit("F2");
    114 : Exit("F3");
    115 : Exit("F4");
    116 : Exit("F5");
    117 : Exit("F6");
    118 : Exit("F7");
    119 : Exit("F8");
    120 : Exit("F9");
    121 : Exit("F10");
    122 : Exit("F11");
    123 : Exit("F12");
    144 : Exit("Num Lock");
    145 : Exit("Scroll Lock");
    186 : Exit("Semi-Colon");
    187 : Exit("Equal Sign");
    188 : Exit("Comma");
    189 : Exit("Dash");
    190 : Exit("Full Stop");
    191 : Exit("Forward Slash");
    192 : Exit("Apostrophe");
    219 : Exit("Open Bracket");
    220 : Exit("Back Slash");
    221 : Exit("Close Braket");
    222 : Exit("Hash Tag");
    else
      Exit(IntToStr(KeyCode)); //If it could not find it, send back the number
  end;
end;


end.
