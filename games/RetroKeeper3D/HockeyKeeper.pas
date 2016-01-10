unit HockeyKeeper;
{
    Copyright (c) 2015 Matthew

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Application,
  SmartCL.Game, SmartCL.GameApp, SmartCL.Graphics;

type
  TDirection = (Topleft, Topright, Bottomleft, Bottomright);
  TCanvasProject = class(TW3CustomGameApplication)
  private
    Retroeepersidetext, Retroeepertext, counting2, flagusable2, Readymessage,
      Pleasewaitmessage, spaceusable, flagusable, counting, Ballmove: boolean;
    count2, flagwaving2, leftflagrotation, flagwaving, systemcount, count, yball,
      direction, saved, balldirection, xball, xspeed, growball, goals: integer;
    crowdleftxpos = 180;
    crowdleftypos = 30;
    crowdrightxpos = 405;
    crowdwidthx = 15;
    crowdwidthy = 20;
    speed = 2;
    howleftright = 50;
    yballbottom = 295;
    ballgrow = 1;
    startcount = 0;
    blueflagleft = 460;
    playerheadcolour = 'rgb(255, 183, 75)';
    crowdheadcolour1 = 'rgb(255, 183, 75)';
  public
    procedure KeyDownEvent (mCode: integer);
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure ballrandomlocation;
    procedure goalsaved;
    procedure goal;
  end;

implementation

procedure TCanvasProject.KeyDownEvent(mCode: integer);
begin
  case mCode of
    27: Application.Terminate;
    65: Direction := Topleft;  // a
    68: Direction := Topright;  // d
    74: Direction := Bottomleft; // j
    76: Direction := Bottomright; // l
    32, 83: begin // space or s
              if spaceusable = true then
                begin
                  Ballmove := True;
                  ballrandomlocation;
                  xball := 0;
                  yballbottom := 0;
                  yball := 0;
                  spaceusable := false;
                end;
            end;
  end;
end;

procedure TCanvasProject.ApplicationStarting;
begin
  inherited;
  asm
    window.onkeydown=function(e)
    {
    TCanvasProject.KeyDownEvent(Self,e.keyCode);
    }
    window.focus();
  end;
  KeyDownEvent(0);
  randomize;
  GameView.Delay := 20;
  GameView.StartSession(True);
  flagusable := false;
  flagusable2 := false;
end;

procedure TCanvasProject.ballrandomlocation;
begin
  balldirection := randomint(4) + 1;
end;

procedure TCanvasProject.goalsaved;
begin
  saved += 1;
  counting := true;
  flagusable := true;
  spaceusable := true;
end;

procedure TCanvasProject.goal;
begin
  counting2 := true;
  flagusable2 := true;
  goals += 1;
  spaceusable := true;
end;

procedure TCanvasProject.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TCanvasProject.PaintView(Canvas: TW3Canvas);
  procedure DrawPlayerStill;
    begin
      growball := 0;
      Canvas.FillStyle := 'rgb(255, 255, 255)'; // draws ball colour
      canvas.beginpath;
      Canvas.ellipse(295, 40, 295 + 10, 40 + 10); // draws ball still
      canvas.fill;
      // Draw player in start position
      canvas.StrokeStyle := 'rgb(200, 200, 0)';
      canvas.BeginPath;
      Canvas.FillStyle := playerheadcolour; // draws player head
      Canvas.FillRectF(285, 190, 30, 30);
      Canvas.FillStyle := 'rgb(255, 0, 0)'; // draws player body
      Canvas.FillRectF(270, 220, 60, 50);
      Canvas.FillStyle := 'rgb(0, 0, 255)'; //draws player legs
      Canvas.FillRectF(280, 270, 40, 40);
      canvas.Stroke;
    end;

  procedure Gamebackground;
  begin
    // please wait message
    if systemcount = (startcount + 0) then
      begin
        Pleasewaitmessage := true;
        Retroeepertext := true;
      end;
    if systemcount - startcount in [20, 60, 100] then
      Pleasewaitmessage := false;
    if systemcount - startcount in [40, 80] then
      Pleasewaitmessage := true;
    if systemcount = startcount + 120 then
      Readymessage := true;
    if systemcount = startcount + 180 then
      begin
        Readymessage := false;
        spaceusable := true;
        Retroeepertext := false;
        Retroeepersidetext := true;
      end;

    systemcount += 1;
    if counting = true then
      begin
        count := systemcount;
        counting := false;
      end;

    if flagusable = true then  // red flag (on left) for a save
      begin

        if (systemcount = count + 20) or (systemcount = count + 60) then
          flagwaving := 1;
        if (systemcount = count + 40) or (systemcount = count + 80) then
          flagwaving := 2;

        if systemcount = count + 100 then
          begin
            flagwaving := 0;
            flagusable := false;
            spaceusable := true;
          end;

        //animation here
        case flagwaving of
          1: begin
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 255, 255)';
               canvas.MoveToF(75, 200);
               canvas.LineToF(70 + leftflagrotation, 180);
               canvas.Stroke;
               canvas.ClosePath;
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 0, 0)';
               for var i := 1 to 6 do
                 begin
                   canvas.MoveToF(72 + leftflagrotation, 180 - i);
                   canvas.LineToF(42 + leftflagrotation, 190 - i);
                 end;
               canvas.Stroke;
               canvas.ClosePath;
               leftflagrotation := leftflagrotation + 1;
             end;
          2: begin
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 255, 255)';
               canvas.MoveToF(75, 200);
               canvas.LineToF(70 + leftflagrotation, 180);
               canvas.Stroke;
               canvas.ClosePath;
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 0, 0)';
               for var i := 1 to 6 do
                 begin
                   canvas.MoveToF(90 + leftflagrotation,175 - i);
                   canvas.LineToF(70 + leftflagrotation,185 - i);
                 end;
               canvas.Stroke;
               canvas.ClosePath;
               leftflagrotation := (leftflagrotation - 1);
             end;
          end;
      end; // if flagusable

    if flagusable2 = true then // blue flag (on right) for a goal
      begin
        if (systemcount = count2 + 20) or (systemcount = count2 + 60) then
          flagwaving2 := 1;
        if (systemcount = count2 + 40) or (systemcount = count2 + 80) then
          flagwaving2 := 2;
        if systemcount = count2 + 100 then
          begin
            flagwaving2 := 0;
            flagusable2 := false;
            spaceusable := true;
          end;

        if counting2 = true then
          begin
            count2 := systemcount;
            counting2 := false;
          end;

        case flagwaving2 of
          1: begin
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 255, 255)';
               canvas.MoveToF(75 + blueflagleft, 200);
               canvas.LineToF(70 + leftflagrotation + blueflagleft, 180);
               canvas.Stroke;
               canvas.ClosePath;
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(0, 0, 255)';
               for var i := 1 to 6 do
                 begin
                   canvas.MoveToF(72 + blueflagleft + leftflagrotation, 180 - i);
                   canvas.LineToF(42 + blueflagleft + leftflagrotation, 190 - i);
                 end;
               canvas.Stroke;
               canvas.ClosePath;
               leftflagrotation := (leftflagrotation + 1);
             end;
          2: begin
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(255, 255, 255)';
               canvas.MoveToF(75 + blueflagleft, 200);
               canvas.LineToF(70 + blueflagleft + leftflagrotation, 180);
               canvas.Stroke;
               canvas.ClosePath;
               canvas.BeginPath;
               canvas.StrokeStyle := 'rgb(0, 0, 255)';
               for var i := 1 to 6 do
                 begin
                   canvas.MoveToF(90 + blueflagleft + leftflagrotation, 175 - i);
                   canvas.LineToF(70 + blueflagleft + leftflagrotation, 185 - i);
                 end;
               canvas.Stroke;
               canvas.ClosePath;
               leftflagrotation := leftflagrotation - 1;
             end;
        end; // case flagwaving2
      end; // if flagwaving2
    for var i := 1 to 16 do
      begin
        Canvas.FillStyle := crowdheadcolour1; // draw crowd head
        canvas.beginpath;
        Canvas.ellipse(crowdleftxpos - 9 * i, crowdleftypos + 15 * i,
                       crowdleftxpos + crowdwidthx - 9 * i, crowdleftypos + crowdwidthy + 15 * i);
        Canvas.ellipse(crowdrightxpos + 9 * i, crowdleftypos + 15 * i,
                       crowdrightxpos + crowdwidthx + 9 * i,crowdleftypos + crowdwidthy + 15 * i);
        canvas.fill;
        canvas.StrokeStyle := 'rgb(255, 0, 0)';
        canvas.BeginPath;
        canvas.MoveToF(50,290);
        canvas.LineToF(193,52);
        canvas.Stroke;
        canvas.ClosePath;
        canvas.BeginPath;
        canvas.StrokeStyle := 'rgb(0, 0, 255)';
        canvas.MoveToF(550, 290);
        canvas.LineToF(408, 52);
        canvas.Stroke;
        canvas.ClosePath;
      end;
    Canvas.FillStyle := playerheadcolour; //draws player head
    Canvas.FillRectF(293, 13, 14, 7);
    Canvas.FillStyle := 'rgb(0, 0, 255)'; //draws player body
    Canvas.FillRectF(285, 20, 30, 15);
    Canvas.FillStyle := 'rgb(255, 0, 0)'; //draws player legs
    Canvas.FillRectF(295, 35, 10, 15);
    canvas.StrokeStyle := 'rgb(255, 255, 255)';
    canvas.BeginPath;
    canvas.MoveToF(200,50); // side lines
    canvas.LineToF(50,300);
    canvas.MoveToF(400,50);
    canvas.LineToF(550,300);
    canvas.MoveToF(200,50); //back goal side lines
    canvas.LineToF(250,50);
    canvas.MoveToF(350,50);
    canvas.LineToF(400,50);
    canvas.MoveToF(48,300); // front goal side lines
    canvas.LineToF(150,300);
    canvas.MoveToF(450,300);
    canvas.LineToF(552,300);
    canvas.Stroke;
    canvas.ClosePath;
    canvas.StrokeStyle := 'rgb(255, 255, 255)';//back goal
    canvas.BeginPath;
    canvas.MoveToF(250,50);
    canvas.LineToF(250,10);
    canvas.MoveToF(350,50);
    canvas.LineToF(350,10);
    canvas.MoveToF(250,10);
    canvas.LineToF(350,10);
    canvas.MoveToF(150,300); //front goal
    canvas.LineToF(150,150);
    canvas.MoveToF(450,300);
    canvas.LineToF(450,150);
    canvas.MoveToF(150,150);
    canvas.LineToF(450,150);
    canvas.Stroke;
    Canvas.Font := '10pt verdana';
    Canvas.FillStyle := 'rgb(255, 255, 255)';
    canvas.LineWidth := 5;
    Canvas.FillTextF('Saves: ' + IntToStr(saved), 10, 10, MAX_INT);
    Canvas.FillTextF('Goals: ' + IntToStr(goals), 75, 10, MAX_INT);
    Canvas.FillTextF('See pp4s.co.uk for credits' , 10, 30, MAX_INT);
    Canvas.Font := 'bold italic 12pt arial';
    if Retroeepertext = true then
      Canvas.FillTextF('Retro Keeper 3D', 245, 110, MAX_INT);
    if Retroeepersidetext = true then
      Canvas.FillTextF('Retro Keeper 3D', 475, 12, MAX_INT);
      Canvas.Font := '10pt verdana';
    if Pleasewaitmessage = true then
      Canvas.FillTextF('Please Wait', 260, 130, MAX_INT);
    if Readymessage = true then
      Canvas.FillTextF('Ready', 277, 130, MAX_INT);
  end; //inner proc

begin // PaintView
  Canvas.FillStyle := 'rgb(0, 99, 0)';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
  GameBackground;
  Canvas.FillStyle := "rgb(255, 255, 255)"; // for white ball
  if Ballmove = false then
    DrawPlayerStill;

  if Ballmove = true then
    begin
      Canvas.FillStyle := "rgb(255, 255, 255)"; // for white ball
      if (yball = 60) or (yballbottom = 60) then // makes ball get bigger
        growball += ballgrow;
      if (yball = 90)  or (yballbottom = 90) then // makes ball get bigger
        growball += ballgrow;
      if (yball = 120) or (yballbottom = 120) then // makes ball get bigger
        growball += ballgrow;
      if (yball = 130) or (yballbottom = 130) then // makes ball get bigger
        growball += ballgrow;
      if yball = 140 then // stops ball moving at y = 140
        begin//outer begin 1
          yball := 0;
          Ballmove := false;
          case Direction of //case 1
            Topright: if balldirection = 2 then
                        goalsaved;
            Topleft: if balldirection = 1 then
                       goalsaved;
          end; // end of case 1
        end; // end of outer begin 1
      if yballbottom >= 260 then //stops ball moving at y = 260
        begin//outer begin 2
          yball := 0;
          Ballmove := false;
          case Direction of //case 2
            Bottomright: if balldirection = 4 then
                           goalsaved;
            Bottomleft: if balldirection = 3 then
                          goalsaved;
          end; // end of case 2
        end; // end of outer begin 2
      case balldirection of // case 3
        1: begin
             xspeed := 2;
             inc(yball, speed);
             inc(xball, xspeed);
             canvas.beginpath;
             Canvas.ellipse(295 - xball - growball, 40 + yball - growball, 295 - xball + 10 + growball,40 + 10 + growball + yball); //draws ball moving
             canvas.Fill;
             if yball = 140 then
               if not (Direction = TopLeft) then
                   goal;
           end;
        2: begin
             xspeed := 2;
             inc(yball, speed);
             inc(xball, xspeed);
             canvas.beginpath;
             Canvas.ellipse(295 + xball - growball, 40 + yball - growball,
                            295 + xball + 10 + growball, 40 + yball + 10 + growball); //draws ball moving
             canvas.Fill;
             if yball = 140 then
               if not (Direction = Topright) then
                 goal;
           end;
        3: begin
             xspeed := 1;
             inc(yballbottom, speed);
             inc(xball, xspeed);
             canvas.beginpath;
             Canvas.ellipse(295 - xball - growball, 40 + yballbottom - growball,
                            295 - xball + 10 + growball,40 + yballbottom + 10 + growball); //draws ball moving
             canvas.Fill;
             if yballbottom = 260 then
               if not (Direction = Bottomleft) then
                 goal;
           end;
        4: begin
             xspeed := 1;
             inc(yballbottom, speed);
             inc(xball, xspeed);
             canvas.beginpath;
             Canvas.ellipse(295 + xball - growball, 40 + yballbottom - growball,
                            295 + xball + 10 + growball,40 + yballbottom + 10 + growball); //draws ball moving
             canvas.Fill;
             if yballbottom = 260 then
               if not (Direction = Bottomright) then
                 goal;
           end;
      end; // case

      case Direction of // case 4
        Topright: begin // draws player topright
                    canvas.StrokeStyle := 'rgb(200, 200, 0)';
                    canvas.BeginPath;
                    canvas.MoveToF(340 + howleftright, 240);
                    canvas.LineToF(380 + howleftright, 180);
                    Canvas.FillStyle := playerheadcolour; // draws player head
                    Canvas.FillRectF(285 + howleftright, 190, 30, 30);
                    Canvas.FillStyle := 'rgb(255, 0, 0)'; // draws player body
                    Canvas.FillRectF(270 + howleftright, 220, 60, 50);
                    Canvas.FillStyle := 'rgb(0, 0, 255)'; // draws player legs
                    Canvas.FillRectF(280 + howleftright, 270, 40, 40);
                    Canvas.FillStyle := 'rgb(255, 255, 255)'; // draws ball colour
                    canvas.Stroke;
                    canvas.ClosePath;
                  end;
        Topleft: begin // draws player topleft
                   canvas.StrokeStyle := 'rgb(200, 200, 0)';
                   canvas.BeginPath;
                   canvas.MoveToF(260 - howleftright,240);
                   canvas.LineToF(220 - howleftright,180);
                   Canvas.FillStyle := playerheadcolour; // draws player head
                   Canvas.FillRectF(285 - howleftright, 190, 30, 30);
                   Canvas.FillStyle := 'rgb(255, 0, 0)'; // draws player body
                   Canvas.FillRectF(270 - howleftright, 220, 60, 50);
                   Canvas.FillStyle := 'rgb(0, 0, 255)'; // draws player legs
                   Canvas.FillRectF(280 - howleftright, 270, 40, 40);
                   Canvas.FillStyle := 'rgb(255, 255, 255)'; //draws ball colour
                   canvas.Stroke;
                   canvas.ClosePath;
                 end;
        Bottomright: begin // draws player Bottomright
                       canvas.StrokeStyle := 'rgb(200, 200, 0)';
                       canvas.BeginPath;
                       canvas.MoveToF(340 + howleftright, 240);
                       canvas.LineToF(380 + howleftright, 300);
                       Canvas.FillStyle := playerheadcolour; // draws player head
                       Canvas.FillRectF(285 + howleftright, 190, 30, 30);
                       Canvas.FillStyle := 'rgb(255, 0, 0)'; // draws player body
                       Canvas.FillRectF(270 + howleftright, 220, 60, 50);
                       Canvas.FillStyle := 'rgb(0, 0, 255)'; // draws player legs
                       Canvas.FillRectF(280 + howleftright, 270, 40, 40);
                       Canvas.FillStyle := 'rgb(255, 255, 255)'; // draws ball colour
                       canvas.Stroke;
                       canvas.ClosePath;
                     end;
        Bottomleft: begin // draws player bottom left
                      canvas.StrokeStyle := 'rgb(200, 200, 0)';
                      canvas.BeginPath;
                      canvas.MoveToF(260 - howleftright, 240);
                      canvas.LineToF(220 - howleftright, 300);
                      Canvas.FillStyle := playerheadcolour; // draws player head
                      Canvas.FillRectF(285 - howleftright, 190, 30, 30);
                      Canvas.FillStyle := 'rgb(255, 0, 0)'; //draws player body
                      Canvas.FillRectF(270 - howleftright, 220, 60, 50);
                      Canvas.FillStyle := 'rgb(0, 0, 255)'; //draws player legs
                      Canvas.FillRectF(280 - howleftright, 270, 40, 40);
                      Canvas.FillStyle := 'rgb(255, 255, 255)'; // draws ball colour
                      canvas.Stroke;
                      canvas.ClosePath;
                    end;
      end; // case 4
    end; // end of if Ballmove = true
end; // end of PaintView

end.
