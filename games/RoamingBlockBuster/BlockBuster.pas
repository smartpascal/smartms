unit BlockBuster;
{
    Copyright (c) 2014 Joel Sutcliffe

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}
interface

uses
  W3System, W3Components, W3Application, W3Game, W3GameApp, W3Graphics;

type
  TApplication = class(TW3CustomGameApplication)
  protected
    procedure  ApplicationStarting; override;
    procedure  ApplicationClosing; override;
    procedure  PaintView(Canvas: TW3Canvas); override;
    procedure  KeyDownEvent(mCode : Integer);
  end;

  TTarget = class(TObject)
  public
    X, Y, Dir, Dircount : Integer;
    constructor Create();
    procedure Move;
  end;

implementation
var
  Redcode, Greencode, Bluecode, Face, bulletX, BulletY, TargetX, TargetY,
    timecount, count, i, score, mobspeed, bullspeed, time, MobY, MobX: integer;
  Fire, Right, Left, Up, Down: Boolean;
  Target: array[0..10] of TTarget;

procedure TTarget.Move;
begin
  inc(Dircount);
  if Dircount = 10 then
    begin
      Dir := Randomint(4) + 1;
      Dircount := 0;           //chooses direction to move in for 5 frames
    end;
  case Dir of
    1: begin
         if X < 299 then
           inc(X)
         else
           dec(i);
       end;
    2: begin
         if X > 0 then
           dec(X)
         else
           dec(i);
       end;
   3: begin
        if Y < 299 then
          inc(Y)
        else
          dec(i);
      end;
   4: begin
        if Y > 0 then
          dec(Y)
        else
          dec(i);
      end;
  end;
end;

constructor TTarget.create;
begin
  //Create target at starting location
  X := Randomint(295) + 5;
  Y := Randomint(295) + 5;
  Dircount := 0;
end;

procedure TApplication.KeyDownEvent(mCode : integer);
begin
  case mCode of
    //move up
    38, 87: begin
              MobY := MobY - Mobspeed;
              Face := 1;
            end;
    //move down
    40, 83: begin
              MobY := MobY + Mobspeed;
              Face := 2;
            end;
    //move right
    39, 68: begin
              MobX := MobX + Mobspeed;
              Face := 3;
            end;
    //move left
    37, 65: begin
              MobX := MobX - Mobspeed;
              Face := 4;
            end;
    32: begin
          if fire = false then  //allows only one bullet at a time
            begin
              fire := true;
              count := 0;
            end;
        end;
  end;
end;

procedure TApplication.ApplicationStarting;
begin
  inherited;
  asm
    window.onkeydown=function(e)
    {
    TApplication.KeyDownEvent(Self,e.keyCode);
    }
  end;
  KeyDownEvent(0);
  MobX := 0;
  MobY := 0;
  i := 0;
  score := 0;
  repeat
    Target[i] := TTarget.Create();      //create the initial targets
    inc(i);
  until i = 10;
  Mobspeed := 2;
  Bullspeed := 2;
  Time := 0;
  TimeCount := 0;
  GameView.Delay := 20;
  GameView.StartSession(True);
end;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  // Clear background
  Canvas.FillStyle := 'rgb(0, 0, 0)';
  Canvas.FillRectF(0, 0, GameView.Width, GameView.Height);
  //Randomise colour for bullet
  Redcode := Randomint(255);
  Greencode := Randomint(255);
  Bluecode := Randomint(255);
  Canvas.Fillstyle := 'rgb(255, 255, 255)';
  Canvas.FillRect(MobX, MobY, 5, 5);
  // Draw the score
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'rgb(255, 255, 255)';
  Canvas.FillTextF('Score:' + IntToStr(Score), 300, 300, MAX_INT);
  //Draw time
  Canvas.Font := '10pt verdana';
  Canvas.FillStyle := 'rgb(255, 255, 255)';
  Canvas.FillTextF('Time:' + IntToStr(Time), 10, 20, MAX_INT);
  //Draw targets
  i := 0;
  repeat
    Target[i].Move;
    inc(i);
  until i = 10;
  i := 0;
  repeat
    Canvas.Fillstyle := 'pink';
    Canvas.FillRect(Target[i].X, Target[i].Y, 5, 5);
    inc(i);
  until i = 10;
  i := 0;
  //Randomise colour for bullet
  Redcode := Randomint(255);
  Greencode := Randomint(255);
  Bluecode := Randomint(255);
  Canvas.Fillstyle := 'rgb(' + InttoStr(Redcode)+ ',' + InttoStr(Greencode) +
                           ',' + InttoStr(Bluecode) +')';
  if fire = true then
    begin
      inc(count);
      if count = 1 then
        begin
          case face of           // decides direction to fire
            1: begin
                 up := true;
                 down := false;
                 left := false;
                 right := false;
               end;
            2: begin
                 down := true;
                 up := false;
                 left := false;
                 right := false;
               end;
            3: begin
                 right := true;
                 left := false;
                 down := false;
                 up := false;
               end;
            4: begin
                 left := true;
                 right := false;
                 down := false;
                 up := false;
               end;
          end;
          BulletX := MobX + 2;      //spawns bullet
          BulletY := MobY + 2;
        end
      else if count = 41 then
        begin
          fire := false;
        end
      else
        begin
          if up = true then                        //moves bullet
            BulletY := BulletY - Bullspeed;
          if down = true then
            BulletY := BulletY + Bullspeed;
          if left = true then
            BulletX := BulletX - Bullspeed;
          if right = true then
            BulletX := BulletX + Bullspeed;
        end;
      //draw bullet
      Canvas.FillRect(BulletX - 1, BulletY - 1, 3, 3);
    end;
  repeat
    if (BulletX < target[i].X + 5) and (BulletX > target[i].X) and
       (BulletY < target[i].Y + 5) and (BulletY > target[i].Y) then
      begin
        Canvas.fillstyle := 'yellow';                   //destroy target effect
        Canvas.fillrect(BulletX - 5, BulletY - 5, 15, 15);
        Target[i].X := randomint(295) + 5;               //spawns new target
        Target[i].Y := randomint(295) + 5;
        inc(score);
      end;
    inc(i);
  until i = 10;
  i := 0;
  inc(timecount);
  if timecount = 100 then
    begin
      inc(time);
      timecount := 0;
    end;
end;

end.
