unit KnowledgeJS;
{
    Copyright (c) 2011 Peter Hearnshaw

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/

    Converted to run in Smart Mobile Studio by PPS
}

interface

uses 
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics, System.Colors,
  SmartCL.Controls.Image, SmartCL.Dialogs;

type
  TApplication = class(TW3CustomGameApplication)
  private
    FImages : Array[0 .. 117] of TW3Image;
    FImageData : TW3ImageData;
    FCounter : Integer;
    shiftx, shifty: real;
    reached : boolean := False;
    currentDestination, destinationType : string;
    degr, distance, currentMinDistance, indexMinDistance, getMouseX, getMouseY  : integer;
    StreetsArr : array [1 .. 140] of string = ['Welbeck Street','Welbeck Street','Welbeck Street','Welbeck Street','Welbeck Street','Welbeck Street','Welbeck Street','Welbeck Street',
    'Wigmore Place','Little Argyll Street','Little Argyll Street','Ganton Street','Bridle Lane','Bridle Lane','Denman Street','Denman Street',
    'New Bond Street','New Bond Street', 'New Bond Street','New Bond Street','New Bond Street','New Bond Street','New Bond Street','New Bond Street','New Bond Street','New Bond Street',
    'Cork Street','Cork Street','Berkeley Street','Berkeley Street','Berkeley Street','Berkeley Street','Berkeley Street',
    'Pall Mall','Pall Mall','Pall Mall','Pall Mall','Pall Mall','Pall Mall','Pall Mall','Sackville Street','Sackville Street','Vigo Street','Vigo Street','Vigo Street','Haymarket','Haymarket',
    'Haymarket','Haymarket','Haymarket','Haymarket','Haymarket','Haymarket','Haymarket','Duncannon Street','Duncannon Street',
    'Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street','Jermyn Street',
    'Northumberland Avenue','Northumberland Avenue','Northumberland Avenue','Northumberland Avenue','Northumberland Avenue','Northumberland Avenue','Northumberland Avenue','Northumberland Avenue',
    'Bow Street','Bow Street','Bow Street','Langley Street','Langley Street','Morwell Street','Morwell Street','Betterton Street','Betterton Street','Swallow Street',
    'Air Street','Air Street','Air Street','Great Windmill Street','Great Windmill Street','Great Windmill Street',
    'Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street','Wardour Street',
    'Park Lane','Park Lane','Park Lane','Park Lane','Adams Row','Adams Row','Weighhouse Street','Weighhouse Street','Weighhouse Street','Weighhouse Street',
    'Hertford Street','Hertford Street','Hertford Street','Hertford Street','North Audley Street','North Audley Street','North Audley Street',
    'Tottenham Court Road','Tottenham Court Road','Tottenham Court Road','Tottenham Court Road','Tottenham Court Road','Tottenham Court Road','Tottenham Court Road',
    'Goodge Street','Goodge Street','Goodge Street','Goodge Street','Portland Place','Portland Place',
    'Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street','Eastcastle Street'];
    StreetXArr : array [1..140] of integer = [544,519,498,487,468,459,443,413,695,1206,1256,1500,1633,1707,1783,1855,708,722,753,811,838,910,926,1022,1032,1080,1164,1227,932,956,1019,1084,1128,2139,2054,
    2005,1906,1893,1761,1552,1440,1540,1464,1433,1376,1966,1977,1989,2034,2046,2084,2096,2142,2156,2557,2635,1357,1462,1519,1667,1779,1836,1895,1937,1973,2548,2695,2733,2848,2880,2900,2942,2939,2926,2966,
    3067,2680,2733,2117,2192,2873,2786,1589,1703,1661,1677,1827,1868,1884,2021,1984,1979,1944,1922,1842,1803,1782,1753,1775,1730,59,208,224,272,250,418,339,371,412,478,622,527,491,419,70,111,126,2227,2204,
    2187,2162,2087,2061,2027,1583,1553,1475,1442,964,1022,1169,1210,1242,1336,1380,1549,1602,1654,1709,1738];
    StreetYArr : array [1..140] of integer = [540,459,391,325,288,230,190,58,346,702,682,878,1018,1138,1266,1257,710,766,773,895,894,1033,1031,1201,1195,1277,1271,1385,1507,1536,1641,1740,1783,1736,1781,
    1814,1865,1884,1949,2073,1358,1527,1325,1338,1351,1384,1383,1424,1496,1480,1546,1609,1661,1697,1582,1581,1767,1709,1674,1602,1544,1505,1477,1459,1431,1773,1811,1832,1850,1887,1853,1882,1900,819,853,
    953,864,926,100,208,600,680,1499,1431,1342,1371,1114,1161,1221,1086,1038,1002,995,937,767,654,645,588,576,508,1683,1879,1895,1955,1366,1312,879,868,855,837,1995,2033,2044,2081,882,988,1069,387,338,311,
    261,160,93,71,68,96,125,156,177,193,480,471,459,427,419,372,358,343,324,323];

    placesArr : array [1..32] of string = ['Hanover Square','John Lewis', 'Royal College of Nursing', 'Cavendish Square', 'All Souls Church', 'Tottenham Court Road Station', 'Dominion Theatre',
    'British Museum', 'Holborn Station', 'Seven Dials', 'Royal Opera House', 'Cleopatra''s Needle', 'Charing Cross Station', 'Trafalgar Sq', 'Leicester Square', 'The Trocadero', 'Piccadilly Circus',
    'London Waterstones', 'St James Square Gardens', 'The Ritz', 'Burlington Arcade', 'Green Park Station', 'Edge of Hyde Park', 'Grosvenor Square', 'Selfridges', 'Bond Street Station', 'Oxford Circus',
    'YHA Oxford Street', 'Covent Garden Tube Station', 'Foyles Bookshop', 'Soho Square', 'Dominion Theatre'];
    placesXArr : array [1..32] of integer = [979, 855,769, 875, 1028, 2208, 2249, 2530, 3140, 2550, 2982, 3082, 2722, 2446, 2262, 1945, 1894, 1725, 1769, 1199, 1281, 1070, 84, 272, 140, 446, 1149, 1624, 2753, 2267, 2059, 2255];
    placesYArr : array [1..32] of integer = [788, 624, 476, 412, 154, 448, 382, 70, 278, 811, 899, 1646, 1613, 1665, 1306, 1296, 1399, 1515, 1802, 1822, 1530, 1860, 2021, 1149, 729, 757, 592, 664, 852, 707, 578, 384];
    placesRadiiArr : array [1..32] of integer = [85, 50, 70, 100, 70, 50, 50, 150, 65, 50, 70, 65, 80, 150, 75, 70, 100, 65, 100, 70, 50, 50, 185, 150, 75, 55, 60, 60, 90, 50, 90, 50];
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure KeyDownEvent(mCode : integer);
    procedure giveMeADestination;
    procedure checkMouse;
    procedure ProcessDialogResult(Sender: TObject; aResult: TW3AlertResult);
  end;

implementation

procedure TApplication.ApplicationStarting;
begin
  inherited;
  asm
    window.onkeydown=function(e)
    {
    @TApplication.KeyDownEvent(@Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  FImageData := TW3ImageData.Create;

  GameView.OnMouseMove := procedure (o : TObject; t : TShiftState; x, y : Integer)
    begin
      getMouseX := x;
      getMouseY := y;
    end;

  GameView.OnMouseDown := procedure(o : TObject; b : TMouseButton; t : TShiftState; x, y : integer)
    begin
      getMouseX := x;
      getMouseY := y;
    end;
  Application.OnDialogSelect := ProcessDialogResult;
  GameView.Width := 500;
  GameView.Height := 500;
  shiftx := 330;
  shifty := 300;
  giveMeADestination;
  GameView.Delay := 20;
  GameView.StartSession(True);
  FImages[0] := TW3Image.Create(nil);
  for var i := 1 to 117 do
   begin
     if not (i in [0 ..8, 10, 18, 20, 28, 30, 38, 40, 48, 50, 58, 60, 68, 70, 78, 80, 88, 90, 98, 100, 108, 110]) then
       begin
         FImages[i] := TW3Image.Create(nil);
       end;
    end;
  FImages[0].LoadFromURL('res/00.png');
  for var i := 1 to 117 do
    if not (i in [0 ..8, 10, 18, 20, 28, 30, 38, 40, 48, 50, 58, 60, 68, 70, 78, 80, 88, 90, 98, 100, 108, 110]) then
      FImages[i].LoadFromURL('res/' + intToStr(i) +  '.png');
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  for var i := 0 to 117 do
    FImages[i].Free;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);

procedure LoadPNG(x1, y1 : integer);
var
  strImageNum : string;
  xi, yi, blockX, blockY, intImageNum : integer;
  fillShape : Array[1 .. 5] Of TPointF;
begin
  blockX := 1 + (-x1 div 300);
  blockY := 1 + (-y1 div 300);
  for xi := 0 to 11 do
    begin
      for yi := 0 to 8 do
        begin
          if (blockX + 1 >= xi) and (blockX - 1 <= xi) and (blockY + 1 >= yi) and
             (blockY - 1 <= yi) then
            begin
              strImageNum := inttostr(xi) + inttostr(yi);
              intImageNum := strToInt(strImageNum);
              if intImageNum in [0 ..8, 10, 18, 20, 28, 30, 38, 40, 48, 50, 58, 60,
                                 68, 70, 78, 80, 88, 90, 98, 100, 108, 110, 118] then
                Canvas.DrawImageF(FImages[0].Handle, x1 + xi * 300, y1 + yi * 300)
              else
                Canvas.DrawImageF(FImages[intImageNum].Handle, x1 + xi * 300, y1 + yi * 300);
            end;
        end;
    end;
  Canvas.StrokeStyle := 'rgb(0, 0, 99)';
  Canvas.BeginPath;
  Canvas.Ellipse(247.5, 247.5, 252.5, 252.5);
  Canvas.Fill;
  Canvas.ClosePath;
  Canvas.FillStyle := 'black';
  Canvas.FillRectF(0, 0, 100, 100);
  Canvas.FillRectF(100, 0, 500, 20);
  Canvas.StrokeStyle := 'orange';
  Canvas.BeginPath;
  Canvas.Ellipse(11, 11, 89, 89);
  Canvas.Stroke;
  Canvas.ClosePath;
  //Draw line of arrow
  Canvas.StrokeStyle := ColorToWebStr(clLime);
  Canvas.BeginPath;
  Canvas.LineF(50, 50, 50 + round(28 * cos(0.017453 * (degr + 90 + 180))), 50 + round(28 * sin(0.017453 * (degr + 90 + 180))));
  Canvas.Stroke;
  Canvas.ClosePath;
  //Draw head of arrow
  fillShape[1].X := 50 + round(26 * cos(0.017453 * (degr + 90 + 180)));
  fillShape[1].Y := 50 + round(26 * sin(0.017453 * (degr + 90 + 180)));
  fillShape[2].X := 50 + round(26 * cos(0.017453 * (degr + 20 + 90 + 180)));
  fillShape[2].Y := 50 + round(26 * sin(0.017453 * (degr + 20 + 90 + 180)));
  fillShape[3].X := 50 + round(35 * cos(0.017453 * (degr + 90 + 180)));
  fillShape[3].Y := 50 + round(35 * sin(0.017453 * (degr + 90 + 180)));
  fillShape[4].X := 50 + round(26 * cos(0.017453 * (degr - 20 + 90 + 180)));
  fillShape[4].Y := 50 + round(26 * sin(0.017453 * (degr - 20 + 90 + 180)));
  fillShape[5].X := 50 + round(26 * cos(0.017453 * (degr + 90 + 180)));
  fillShape[5].Y := 50 + round(26 * sin(0.017453 * (degr + 90 + 180)));
  Canvas.FillStyle := ColorToWebStr(clLime);
  Canvas.BeginPath;
  Canvas.MoveTo(fillShape[1]);
  for var i := 2 to 5 do
    Canvas.LineTo(fillShape[i]);
  Canvas.Fill;
  Canvas.ClosePath;
  Canvas.Font := '12pt verdana';
  Canvas.FillStyle := 'white';
  Canvas.FillTextF('Destination: ' + currentDestination, 105, 15, MAX_INT );
end;

begin  //PaintView
  inc(FCounter);
  if FCounter < 250 then
    begin
      // Clear background
      Canvas.FillStyle := 'rgb(0, 0, 99)';
      Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
      Canvas.FillStyle := 'yellow';
      Canvas.Font := '14pt Times';
      Canvas.FillTextF('Loading images ...', 50, 50, Max_Int);
      Canvas.FillStyle := 'white';
      Canvas.FillTextF('Use Internet Explorer not Chrome, Firefox or Opera.', 50, 100, Max_Int);
      Canvas.FillTextF('You will be given a random destination.', 50, 150, Max_Int);
      Canvas.FillTextF('An arrow at the top left of the screen will point to it.', 50, 200, Max_Int);
      Canvas.FillTextF('Drag the mouse to guide the taxi.', 50, 250, Max_Int);
      Canvas.FillTextF('Press Escape to exit.', 50, 300, Max_Int);
    end
  else
    begin
      if not reached then
        begin
          checkMouse;
          if shiftx > 3300 then
            shiftx := 3300;
          if shifty > 2100 then
            shifty := 2100;
          if (shiftx < 0) then
            shiftx := 0;
          if (shifty < 0) then
            shifty := 0;
          FImageData := Canvas.toImageData;
          if (FImageData.getpixel(250, 247).R > 200) and (FImageData.getpixel(250, 247).G > 200) and
             (FImageData.getpixel(250, 247).B < 200) then
            shifty := shifty + 2;
          if (FImageData.getpixel(250, 253).R > 200) and (FImageData.getpixel(250, 253).G > 200) and
             (FImageData.getpixel(250, 253).B < 200) then  
           shifty := shifty - 2;
          if (FImageData.getpixel(247, 250).R > 200) and (FImageData.getpixel(247, 250).G > 200) and
             (FImageData.getpixel(247, 250).B < 200) then
            shiftx := shiftx + 2;
          if (FImageData.getpixel(253, 250).R > 200) and (FImageData.getpixel(253, 250).G > 200) and
             (FImageData.getpixel(253, 250).B < 200) then
            shiftx := shiftx - 2;

          // Clear background
          Canvas.FillStyle := 'rgb(0, 0, 99)';
          Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
          Canvas.FillStyle := 'blue';
          LoadPNG(round(-shiftx), round(-shifty));
          //Larger circle to make taxi more visible.
          {Canvas.BeginPath;
          Canvas.Ellipse(235, 235, 265, 265);
          Canvas.Stroke;
          Canvas.ClosePath;}
          if (destinationType = 'street') then
            begin
              currentMinDistance := 10000;
              indexMinDistance := 0;
              for var a := 1 to 140 do
                begin
                  if (StreetsArr[a] = currentDestination) then
                    begin
                      distance := round(sqrt((StreetXArr[a] - shiftx) * (StreetXArr[a] - shiftx) + (StreetYArr[a] - shifty) * (StreetYArr[a] - shifty)));
                      if (distance < currentMinDistance) then
                        begin
                          indexMinDistance := a;
                          currentMinDistance := distance;
                        end;
                    end;
                end;
              //indexMinDistance now contains the index of the closest vertex on the current
              // destination street
              degr := round(57.2957795 * arctan((StreetXArr[indexMinDistance] - shiftx) / (shifty - StreetYArr[indexMinDistance])));
              if (degr < 0 ) then
                  degr := degr + 180;
              if (StreetXArr[indexMinDistance] < shiftx) then //place is to the right of taxi
                  degr := degr + 180;

              if (StreetXArr[indexMinDistance] + 10 > shiftx) and
                 (StreetXArr[indexMinDistance] - 10 < shiftx) and
                 (StreetYArr[indexMinDistance] + 10 > shifty) and
                 (StreetYArr[indexMinDistance] - 10 < shifty) then
                begin
                  Application.ShowDialog('Destination reached!', 'Another Destination?', aoYesNo);
                  reached := true;
                end;
            end
          else
            begin
              for var a := 1 to 32 do
                begin
                  if (PlacesArr[a] = currentDestination) then
                    begin
                      degr := round(57.2957795 * arctan((placesXArr[a] - shiftx) / (shifty - placesYArr[a])));
                      if (degr < 0) then
                        degr := degr + 180;
                      if (placesXArr[a] < shiftx) then //place is to the right of taxi
                        degr := degr + 180;
                      if (placesXArr[a] + (placesRadiiArr[a] / 2) > shiftx) and
                         (placesXArr[a] - (placesRadiiArr[a] / 2) < shiftx) and
                         (placesYArr[a] + (placesRadiiArr[a]/2) > shifty) and
                         (placesYArr[a] - (placesRadiiArr[a]/2) < shifty) then
                         begin
                           Application.ShowDialog('Destination reached!', 'Another Destination?', aoYesNo);
                           reached := true;
                         end;
                    end;
                end;
            end;
          end; //if not reached
       end;
end;

procedure TApplication.ProcessDialogResult(Sender: TObject; aResult: TW3AlertResult);
begin
  if aResult = roYes then
    begin
      giveMeADestination;
      reached := False;
    end
  else
    Application.Terminate;
end;

procedure TApplication.giveMeADestination;
var
  chooseAnotherDestination : boolean = false;
  a, i : integer;
begin
  i := trunc(2 * random);
  if i = 0 then
    begin   //choose a street
      repeat
        a := trunc(139 * random) + 1;
        destinationType := 'street';
        currentDestination := StreetsArr[a];
        chooseAnotherDestination := false;
        for a := 1 to 140 do
          begin
            if (StreetsArr[a] = currentDestination) then
              begin
                distance := round(sqrt((StreetXArr[a] - shiftx) * (StreetXArr[a] - shiftx) + (StreetYArr[a] - shifty) * (StreetYArr[a] - shifty)));
                if distance < 500 then
                  begin
                    chooseAnotherDestination := true;
                  end;
              end;
          end;
      until chooseAnotherDestination = false;
    end
  else
    begin   //choose a place
      repeat
        a := trunc(31 * random) + 1;
        destinationType := 'place';
        currentDestination := PlacesArr[a];
        chooseAnotherDestination := false;
        distance := round(sqrt((PlacesXArr[a] - shiftx) * (PlacesXArr[a] - shiftx) + (PlacesYArr[a] - shifty) * (PlacesYArr[a] - shifty)));
        if distance < 500 then
          begin
            chooseAnotherDestination := true;
          end;
      until chooseAnotherDestination = false;
   end;
end;

procedure TApplication.checkMouse;
var
  degr, distanceAway, xDist, yDist : integer;
begin
  xDist := getMouseX - 250;
  yDist := getMouseY - 250;
  if xDist <> 0 then
    degr := 90 + round(arctan(yDist / xDist) / 3.141 * 180);
  if -xDist > 0 then
    degr := degr + 180;

  distanceAway := round(0.02 * sqrt(xDist * xDist + yDist * yDist));
  if distanceAway > 2 then
    distanceAway := 2;

  shiftx := shiftx + (distanceAway * sin(-(degr + 180) / 180 * 3.141));
  shifty := shifty + (distanceAway * cos(-(degr + 180) / 180 * 3.141));
  if shiftx >= 3216 then
    shiftx := 3216;
  if shifty >= 2081 then
    shifty := 2081;
  if shiftx <= 58 then
   shiftx := 58;
  if shifty <= 58 then
    shifty := 58;
end;

procedure TApplication.KeyDownEvent(mCode : integer);
begin
  case mCode of
    27 : Application.Terminate;
  end;
end;

end.