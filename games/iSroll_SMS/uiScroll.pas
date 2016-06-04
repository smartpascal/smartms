unit uiScroll;

interface

uses 
  SmartCL.System, System.Types, EventObjs, W3C.DOM, System.Colors,
  System.Diagnostics,

  SmartCL.Components;

type
  TW3DispatchHandle = THandle;
  TW3DOMEvent = class(TEventObj);

type
  TW3Range = record
    Maximum: integer;
    Minimum: integer;
    class function Create(const aMinimum: Integer; const aMaximum: Integer) : TW3Range;
    function ClipTo(const Value: Integer) : Integer;
  end;

  /*TW3Range = class
    Maximum: integer;
    Minimum: integer;
    constructor Create(aMinimum: Integer; aMaximum: Integer);
    function ClipTo(const Value: Integer) : Integer;
  end;*/

  TScrollContent = class(TW3CustomControl)
    procedure SetInitialTransformationStyles;
    procedure StyleTagObject; override; empty;
  end;

  TW3ScrollIndicator = class(TW3MovableControl)
  procedure StyleTagObject; override; empty;
  end;

  TW3VScrollControl = class(TW3MovableControl)
  private
    FYOffset: integer;
    FContent: TScrollContent;
    FVRange:  TW3Range;
    FHRange:  TW3Range;
    //FVRange2:  TW3Range2;
    //FHRange2:  TW3Range2;

    FPressed: boolean;
    FStartY:  integer;

    FTarget: integer;
    FAmplitude: double;
    FTimestamp: integer;
    FVelocity: double;
    FFrame: double;
    FTicker: TW3DispatchHandle;
    FFader: TW3DispatchHandle;
    FTimeConstant: double;

    FMouseDownEvent: TW3DOMEvent;
    FMouseUpEvent: TW3DOMEvent;
    FMouseMoveEvent: TW3DOMEvent;
    FTouchDownEvent: TW3DOMEvent;
    FTouchMoveEvent: TW3DOMEvent;
    FTouchEndsEvent: TW3DOMEvent;

    FIndicator: TW3ScrollIndicator;
    function  GetYPosition(const E: variant): integer;
    procedure MoveBegins(sender: TObject; EventObj: JEvent);
    procedure MoveEnds(sender: TObject; EventObj: JEvent);
    procedure MoveUpdate(sender: TObject; EventObj: JEvent);
    //procedure HandleContentSizeChanged(sender: TObject);

  protected
    procedure Track;virtual;
    procedure AutoScroll;virtual;

    procedure ScrollBegins;virtual;
    procedure ScrollEnds;virtual;

    procedure Resize;override;
    procedure StyleTagObject; override; empty;
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure ObjectReady;override;
    procedure ScrollY(const NewTop: integer);

  public
    procedure HandleContentSizeChanged(sender: TObject);
    Property  Content:TScrollContent read FContent;
  end;


implementation

//###################################################################
// TW3Range
//###################################################################
class function TW3Range.Create(const aMinimum: Integer; const aMaximum: Integer) : TW3Range;
begin
   Result.Minimum := aMinimum;
   Result.Maximum := aMaximum;
end;

function TW3Range.ClipTo(const Value: Integer) : Integer;
begin
   Result := if Value> Maximum then Maximum else
   if Value<Minimum then Minimum else Value;
end;

//###################################################################
// TW3Range
//###################################################################
/*constructor TW3Range.Create(aMinimum: Integer; aMaximum: Integer);
begin
   Minimum := aMinimum;
   Maximum := aMaximum;
end;

function TW3Range.ClipTo(const Value: Integer) : Integer;
begin
   Result := if Value> Maximum then Maximum else
   if Value<Minimum then Minimum else Value;
end;*/

//###################################################################
// TW3VScrollControl
//###################################################################

procedure TW3VScrollControl.InitializeObject;
begin
  inherited;
  FPressed:=false;
  FYOffset := 0;
  FStartY := 0;

  FTimeConstant := 325;

  Background.fromColor(clWhite);
  FContent := TScrollContent.Create(self);
  FIndicator:=TW3ScrollIndicator.Create(self);
  FIndicator.width:=8;
  FIndicator.height:=32;
  //FIndicator.StyleClass:='TW3ScrollContentIndicator';
  FIndicator.Transparent := true;

  FMouseDownEvent := TW3DOMEvent.Create(self);
  FMouseDownEvent.Attach("mousedown");
  FMouseDownEvent.OnEvent := @MoveBegins;

  FMouseMoveEvent := TW3DOMEvent.Create(self);
  FMouseMoveEvent.Attach("mousemove");
  FMouseMoveEvent.OnEvent := @MoveUpdate;

  FMouseUpEvent := TW3DOMEvent.Create(self);
  FMouseUpEvent.Attach("mouseup");
  FMouseUpEvent.OnEvent := @MoveEnds;

  FTouchDownEvent := TW3DOMEvent.Create(self);
  FTouchDownEvent.Attach("touchstart");
  FTouchDownEvent.OnEvent:= @MoveBegins;

  FTouchMoveEvent := TW3DOMEvent.Create(self);
  FTouchMoveEvent.Attach("touchmove");
  FTouchMoveEvent.OnEvent := @MoveUpdate;

  FTouchEndsEvent := TW3DOMEvent.Create(self);
  FTouchEndsEvent.Attach("touchend");
  FTouchEndsEvent.OnEvent := @MoveEnds;

  FContent.Handle.ReadyExecute(
  procedure ()
  begin
    (* Mark content for GPU acceleration *)
     //FContent.SetInitialTransformationStyles;
    FContent.Handle.style[w3_CSSPrefix('transformStyle')] := 'preserve-3d';
    FContent.Handle.style[w3_CSSPrefix('Perspective')] := 800;
    FContent.Handle.style[w3_CSSPrefix('transformOrigin')] := '50% 50%';
    FContent.Handle.style[w3_CSSPrefix('Transform')] := 'translateZ(0px)';

    //FContent.Handle.style['height'] := '100%';
    FContent.Handle.style['height'] := null;
    FContent.Handle.style['padding-top'] := '30px';
    FContent.Handle.style['padding-bottom'] := '30px';

  end);
end;

procedure TScrollContent.SetInitialTransformationStyles;
begin
end;

procedure TW3VScrollControl.ObjectReady;
begin
  inherited;
    //FVRange2 := FVRange2.Create(0, FContent.ScrollInfo.ScrollHeight);
    //FHRange2 := FVRange2.Create(0, FContent.Width);

  //WriteLn('TW3VScrollControl.ObjectReady');
  FContent.OnReSize := HandleContentSizeChanged;
  FIndicator.left:=ClientWidth-FIndicator.width;
  //FIndicator.bringToFront;
  FIndicator.Visible:=false;
  Resize;

end;

procedure TW3VScrollControl.FinalizeObject;
begin
  FContent.free;
  inherited;
end;

procedure TW3VScrollControl.HandleContentSizeChanged(sender: TObject);
begin
  //WriteLn('HandleContentSizeChanged');
  if not (csDestroying in ComponentState) then
  begin
    //FVRange := TW3Range.Create(0, FContent.Height - ClientHeight);
    //FHRange := TW3Range.Create(0, FContent.Width - ClientWidth);

    FVRange := TW3Range.Create(0, FContent.ScrollInfo.ScrollHeight);
    FHRange := TW3Range.Create(0, FContent.Width - ClientWidth);

    /*FVRange := FVRange.Create(0, FContent.ScrollInfo.ScrollHeight);
    FHRange := FHRange.Create(0, FContent.Width);*/
    Handle.style['width'] := '100%';
    FContent.Handle.style['width'] := '100%';
    FContent.Handle.style['height'] := IntToStr(FContent.ScrollInfo.ScrollHeight)+'px';
  end;
end;

procedure TW3VScrollControl.Resize;
var
  LClient:  TRect;
begin
  inherited;

  //WriteLn('Resize');
  if (csReady in ComponentState) then
  begin

    LClient := ClientRect;
    FVRange := TW3Range.Create(0, FContent.Height - LClient.Height);
    FHRange := TW3Range.Create(0, FContent.Width - LClient.Width);
    FContent.SetBounds(0,FContent.top,LClient.Width,FContent.height);
    FIndicator.MoveTo(ClientWidth-FIndicator.Width,FIndicator.top);

  end;
end;

procedure TW3VScrollControl.ScrollY(const NewTop: integer);
var
  LGPU: string;
  LIndicatorTarget: integer;

  function GetRelativePos:double;
  begin
    result := (ClientHeight - FIndicator.Height) / (FContent.Height - ClientHeight);
  end;

begin
  if not (csDestroying in ComponentState) then
  begin
    if (csReady in ComponentState) then
    begin
      (* Use GPU scrolling to position the content *)
      FYOffset := FVRange.ClipTo(NewTop);
      LGPU := "translate3d(0px,";
      LGPU += FloatToStr(-FYOffset) + "px, 0px)";
      //FContent.Handle.style[BrowserAPI.Prefix("Transform")] := LGPU;
      FContent.Handle.style[w3_CSSPrefix("Transform")] := LGPU;


      (* Use GPU scrolling to position the indicator *)
      LIndicatorTarget := FYOffset * GetRelativePos;
      FIndicator.left := clientwidth - FIndicator.width;
      LGPU :="translateY(" + TInteger.ToPxStr(LIndicatorTarget) + ")";
      //FIndicator.Handle.style[BrowserAPI.Prefix("Transform")]:= LGPU;
      FIndicator.Handle.style[w3_CSSPrefix("Transform")]:= LGPU;
    end;
  end;
end;

procedure TW3VScrollControl.Track;
var
  LNow: integer;
  Elapsed: integer;
  Delta: double;
  V: double;
begin
LNow := ceil(PerformanceTimer.Now);


  //LNow := TW3Dispatch.JsNow.now();
  Elapsed := LNow - FTimestamp;
  //FTimestamp := TW3Dispatch.JsNow.now();
  FTimestamp := ceil(PerformanceTimer.Now);
  Delta := FYOffset - FFrame;
  FFrame := FYOffset;
  v := 1000 * Delta / (1 + Elapsed);
  FVelocity := 0.8 * v + 0.2 * FVelocity;
end;

procedure TW3VScrollControl.ScrollBegins;
begin
  w3_ClearInterval(FFader);
  //TW3Dispatch.ClearInterval(FFader);
  if not (csDestroying in ComponentState) then
  begin
    FIndicator.Visible := true;
    FIndicator.AlphaBlend := true;
    FIndicator.Opacity := 255;
  end;
end;

procedure TW3VScrollControl.ScrollEnds;
begin
  w3_ClearInterval(FFader);
  //TW3Dispatch.ClearInterval(FFader);
  if not (csDestroying in ComponentState) then
  begin

    FFader := w3_SetInterval(procedure ()
      begin
        FIndicator.AlphaBlend := true;
        FIndicator.Opacity := FIndicator.Opacity - 10;
        if FIndicator.Opacity=0 then
        begin
          //TW3Dispatch.ClearInterval(FFader);
          w3_ClearInterval(FFader);
        end;
      end,
      50);
  end;
end;

procedure TW3VScrollControl.AutoScroll;
var
  Elapsed: integer;
  Delta: double;
begin
  if FAmplitude<>0 then
  begin
    //Elapsed := TW3Dispatch.JsNow.now() - FTimestamp;
    Elapsed := ceil(PerformanceTimer.Now) - FTimestamp;
    Delta := -FAmplitude * Exp(-Elapsed / FTimeConstant);
  end;

  (* Scrolled passed end-of-document ? *)
  if (FYOffset >= (FContent.Height - ClientHeight)) then
  begin
    //TW3Dispatch.ClearInterval(FTicker);
    w3_ClearInterval(FTicker);
    FTicker := unassigned;
    ScrollY(FContent.Height-ClientHeight);
    ScrollEnds;
    exit;
  end;

  (* Scrolling breaches beginning of document? *)
  if (FYOffset < 0) then
  begin
    //TW3Dispatch.ClearInterval(FTicker);
    w3_ClearInterval(FTicker);
    FTicker := unassigned;
    ScrollY(0);
    ScrollEnds;
    exit;
  end;

  if (delta > 5) or (delta < -5) then
  begin
    ScrollY(FTarget + Delta);
    W3_RequestAnimationFrame(AutoScroll);
  end else
  begin
    ScrollY(FTarget);
    ScrollEnds;
  end;
end;

function TW3VScrollControl.GetYPosition(const e: variant): integer;
begin
  if ( (e.targetTouches) and (e.targetTouches.length >0)) then
  result := e.targetTouches[0].clientY else
  result := e.clientY;
end;

procedure TW3VScrollControl.MoveBegins(sender: TObject; EventObj: JEvent);
begin
  FPressed := true;
  FStartY := GetYPosition(EventObj);
  FVelocity := 0;
  FAmplitude := 0;
  FFrame := FYOffset;
  //FTimestamp := TW3Dispatch.JsNow.now();
  FTimestamp := ceil(PerformanceTimer.Now);
  //TW3Dispatch.ClearInterval(FTicker);
  w3_ClearInterval(FTicker);
  //FTicker := TW3Dispatch.SetInterval(Track,100);
  FTicker := w3_SetInterval(Track,100);
  EventObj.preventDefault();
  EventObj.stopPropagation();
end;

procedure TW3VScrollControl.MoveUpdate(sender: TObject; EventObj: JEvent);
var
  y, delta: integer;
begin
  if FPressed then
  begin
    y := GetYPosition(eventObj);
    delta := (FStartY - Y);
    if (Delta>2) or (Delta < -2) then
    begin
      FStartY := Y;
      ScrollY(FYOffset + Delta);
    end;
  end;
  EventObj.preventDefault();
  EventObj.stopPropagation();
end;

procedure TW3VScrollControl.MoveEnds(sender: TObject; EventObj: JEvent);
begin
  FPressed := false;
  //TW3Dispatch.ClearInterval(FTicker);
  w3_ClearInterval(FTicker);
  if (FVelocity > 10) or (FVelocity < -10) then
  begin
    FAmplitude := 0.8 * FVelocity;
    FTarget := round(FYOffset + FAmplitude);
    //FTimeStamp := TW3Dispatch.JsNow.Now();
    FTimeStamp := ceil(PerformanceTimer.Now);

    ScrollBegins;
    w3_requestAnimationFrame(autoscroll);
  end;
  EventObj.preventDefault();
  EventObj.stopPropagation();
end;

end.
