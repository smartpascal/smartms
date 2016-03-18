unit system.animation.tween;

interface

uses
  System.Types,
  SmartCL.Time,
  SmartCL.System;

type
/*
  TW3TweenAnimationType = (
    ttlinear,
    ttQuadIn,
    ttQuadOut,
    ttQuadInOut,
    ttCubeIn,
    ttCubeOut,
    ttCubeInOut,
    ttQuartIn,
    ttQuartOut,
    ttQuartInOut,
    ttQuintIn,
    ttQuintOut,
    ttQuintInOut,
    ttSineIn,
    ttSineOut,
    ttSineInOut,
    ttExpoIn,
    ttExpoOut,
    ttExpoInOut
    );
*/

TW3TweenAnimationType = (
  ttLinear,
  ttQuadOut,
  ttQuadIn,
  ttQuadInOut,
  ttQuadOutIn,
  ttExpoOut,
  ttExpoIn,
  ttExpoInOut,
  ttExpoOutIn,
  ttCubicOut,
  ttCubicIn,
  ttCubicInOut,
  ttCubicOutIn,
  ttQuartOut,
  ttQuartIn,
  ttQuartInOut,
  ttQuartOutIn,
  ttQuintOut,
  ttQuintIn,
  ttQuintInOut,
  ttQuintOutIn,
  ttCircOut,
  ttCircIn,
  ttCircInOut,
  ttCircOutIn,
  ttSineOut,
  ttSineIn,
  ttSineInOut,
  ttSineOutIn,
  ttElasticOut,
  ttElasticIn,
  ttElasticInOut,
  ttElasticOutIn,
  ttBounceOut,
  ttBounceIn,
  ttBounceInOut,
  ttBounceOutIn,
  ttBackOut,
  ttBackIn,
  ttBackInOut,
  ttBackOutIn);
  
  TW3TweenBehavior = (
    tbSingle,         // Execute once and then stops
    tbRepeat,         // Repeats the tween sequence
    tbOscillate      // Executes between A and B in oscillating manner
    );

  TW3TweenData    = class;
  TW3TweenElement = class;
  TW3Tween        = class;


  TW3TweenItemUpdatedEvent = procedure (Item:TW3TweenElement);
  TW3TweenUpdatedEvent = procedure (Sender:TObject);
  TW3TweenStartedEvent = procedure (sender:TObject);
  TW3TweenFinishedEvent = procedure (sender:TObject);
  TW3TweenFinishedPartialEvent = procedure (sender:TObject);

  TW3TweenState = (tsIdle,tsRunning,tsPaused,tsDone);

  TW3TweenData = class
  public
    Property    Id: String;
    Property    StartTime: TDateTime;
    Property    StartValue: Float;
    Property    Distance: Float;
    Property    Duration: Float;
    Property    AnimationType: TW3TweenAnimationType;
    Property    Behavior: TW3TweenBehavior;

    function    Expired: Boolean;virtual;
    Procedure   Reset;virtual;
  end;

  TW3TweenElement = class(TW3TweenData)
  public
    Property    State:TW3TweenState;
    Property    Value:Float;

    Property    OnStarted:TNotifyEvent;
    Property    OnFinished:TNotifyEvent;
    Property    OnPaused:TNotifyEvent;
    Property    OnResumed:TNotifyEvent;
    Property    OnUpdated:TW3TweenItemUpdatedEvent;

    procedure   Update(const aValue:Float);virtual;

    Procedure   Reset;override;
    Constructor Create;virtual;
  end;

  (* Exception class for general TTween errors *)
  EW3TweenError = class(EW3Exception);

  TW3Tween = class
  private
    FTimer:     TW3Timer;
    FValues:    Array of TW3TweenElement;
    FActive:    Boolean;
    FPartial:   Boolean;
    FInterval:  Integer;
    FQRLUT:     Array[TW3TweenAnimationType] of function (t, b, c, d:float):float;
    FNameLUT:   Variant; // USES JS BASED INDEX
    procedure   SetInterval(const Value:Integer);
  protected
    Procedure   HandleSyncUpdate;virtual;
    procedure   HandleUpdateTimer(Sender:TObject);virtual;
    function    Update(const Item:TW3TweenElement):Float;virtual;
  protected
    procedure   TweenStarted(const Item:TW3TweenElement);virtual;
    procedure   TweenComplete(const Item:TW3TweenElement);virtual;
    procedure   TweenPaused(const Item:TW3TweenElement);virtual;
    procedure   TweenResumed(const Item:TW3TweenElement);virtual;
  protected
  	function Linear(T, B, C, D: Float): Float;
  	function ExpoOut(T, B, C, D: Float): Float;
  	function ExpoIn(T, B, C, D: Float): Float;
  	function ExpoInOut(T, B, C, D: Float): Float;
  	function ExpoOutIn(T, B, C, D: Float): Float;
  	function CircOut(T, B, C, D: Float): Float;
  	function CircIn(T, B, C, D: Float): Float;
  	function CircInOut(T, B, C, D: Float): Float;
  	function CircOutIn(T, B, C, D: Float): Float;
  	function QuadOut(T, B, C, D: Float): Float;
  	function QuadIn(T, B, C, D: Float): Float;
  	function QuadInOut(T, B, C, D: Float): Float;
  	function QuadOutIn(T, B, C, D: Float): Float;
  	function SineOut(T, B, C, D: Float): Float;
  	function SineIn(T, B, C, D: Float): Float;
  	function SineInOut(T, B, C, D: Float): Float;
  	function SineOutIn(T, B, C, D: Float): Float;
  	function CubicOut(T, B, C, D: Float): Float;
  	function CubicIn(T, B, C, D: Float): Float;
  	function CubicInOut(T, B, C, D: Float): Float;
  	function CubicOutIn(T, B, C, D: Float): Float;
  	function QuartOut(T, B, C, D: Float): Float;
  	function QuartIn(T, B, C, D: Float): Float;
  	function QuartInOut(T, B, C, D: Float): Float;
  	function QuartOutIn(T, B, C, D: Float): Float;
  	function QuintOut(T, B, C, D: Float): Float;
  	function QuintIn(T, B, C, D: Float): Float;
  	function QuintInOut(T, B, C, D: Float): Float;
  	function QuintOutIn(T, B, C, D: Float): Float;
  	function ElasticOut(T, B, C, D: Float): Float;
  	function ElasticIn(T, B, C, D: Float): Float;
  	function ElasticInOut(T, B, C, D: Float): Float;
  	function ElasticOutIn(T, B, C, D: Float): Float;
  	function BounceOut(T, B, C, D: Float): Float;
  	function BounceIn(T, B, C, D: Float): Float;
  	function BounceInOut(T, B, C, D: Float): Float;
  	function BounceOutIn(T, B, C, D: Float): Float;
  	function BackOut(T, B, C, D: Float): Float;
  	function BackIn(T, B, C, D: Float): Float;
  	function BackInOut(T, B, C, D: Float): Float;
  	function BackOutIn(T, B, C, D: Float): Float;
  /*
    function    Linear(t,b,c,d:float):float; // Linear
    function    QuadIn(t, b, c, d:float):float;
    function    QuadOut(t, b, c, d:float):float;
    function    QuadInOut(t, b, c, d:float):float;
    function    CubeIn(t, b, c, d:float):float;
    function    CubeOut(t, b, c, d:float):float;
    function    CubeInOut(t, b, c, d:float):float;
    function    QuartIn(t, b, c, d:float):float;
    function    QuartOut(t, b, c, d:float):float;
    function    QuartInOut(t, b, c, d:float):float;
    function    QuintIn(t, b, c, d:float):float;
    function    QuintOut(t, b, c, d:float):float;
    function    QuintInOut(t, b, c, d:float):float;
    function    SineIn(t, b, c, d:float):float;
    function    SineOut(t, b, c, d:float):float;
    function    SineInOut(t, b, c, d:float):float;
    function    ExpoIn(t, b, c, d:float):float; // 
    function    ExpoOut(t, b, c, d:float):float; // 
    function    ExpoInOut(t, b, c, d:float):float;// 
*/
  public
    function    ObjectOf(const Id:String):TW3TweenElement;
    function    IndexOf(Id:String):Integer;

    Property    Active:Boolean read ( FActive );
    Property    Item[const index:Integer]:TW3TweenElement read (FValues[index]);
    property    Tween[const Id:String]:TW3TweenElement read ObjectOf;default;
    property    Count:Integer read ( FValues.Length );
    Property    Interval:Integer read FInterval write SetInterval;

    Property    SyncRefresh:Boolean;
    Property    IgnoreOscillate:Boolean;

    function    Add(Id:String):TW3TweenElement;overload;

    Function    Add(Id:String;const aStartValue,aDistance,aDuration:float;
                const aAnimationType:TW3TweenAnimationType;
                const aBehavior:TW3TweenBehavior):TW3TweenElement;overload;

    function    Add(const Instance:TW3TweenElement):TW3TweenElement;overload;

    Procedure   Delete(index:Integer);overload;
    procedure   Delete(Id:String);overload;
    procedure   Delete(const TweenIds:Array of String);overload;

    procedure   Clear;overload;

    procedure   Execute(Finished:TProcedureRef);overload;
    procedure   Execute;overload;
    procedure   Execute(const TweenObjects:Array of TW3TweenElement);overload;

    Procedure   Pause(const Index:Integer);overload;
    procedure   Pause(const Tween:TW3TweenElement);overload;
    procedure   Pause(const Objs:Array of TW3TweenElement);overload;
    procedure   Pause(const Ids:Array of String);overload;
    procedure   Pause;overload;

    Procedure   Resume(const index:Integer);overload;
    procedure   Resume(const Tween:TW3TweenElement);overload;
    procedure   Resume(const Objs:Array of TW3TweenElement);overload;
    procedure   Resume(const Ids:Array of String);overload;
    procedure   Resume;overload;

    procedure   Cancel;overload;

    class function TimeCode:float;

    Constructor Create;virtual;
    Destructor  Destroy;Override;

  published
    Property    OnPartialFinished:TW3TweenFinishedPartialEvent;
    Property    OnUpdated:TW3TweenUpdatedEvent;
    Property    OnFinished:TW3TweenFinishedEvent;
    Property    OnStarted:TW3TweenStartedEvent;
  end;

implementation


Resourcestring
CNT_TWEEN_EXEC_EXISTS_ID =
"Execute failed, a tween-object with id [%s] already exists error";

CNT_TWEEN_EXEC_FAILED_ID =
"Execute failed, element does not have a valid id error";

CNT_TWEEN_EXEC_BUSY =
"Execute failed, tween already active error";

CNT_ERR_TWEEN_ELEMENT_EMPTY_ID =
"Failed to add tween-element, invalid [empty] id error";

CNT_ERR_TWEEN_ELEMENT_DUPLICATE_ID =
"Failed to add tween-element, [%s] already exists in the collection error";

CNT_ERR_TWEEN_ELEMENT_EXISTS =
"Failed to add tween-element [%s], element already exists in collection error";

//############################################################################
// TW3Tween
//############################################################################

Constructor TW3Tween.Create;
begin
  inherited Create;
  FTimer := TW3Timer.Create;

  FNameLUT := TVariant.CreateObject;

  FInterval := 10;
  IgnoreOscillate := true;
  SyncRefresh := false;

  // Build Lookup-Table for faster access
/*  
  FQRLUT[ttLinear] := @Linear;
  FQRLUT[ttQuadIn] := @QuadIn;
  FQRLUT[ttQuadOut] := @QuadOut;
  FQRLUT[ttQuadInOut] := @QuadInOut;
  FQRLUT[ttCubeIn] := @CubeIn;
  FQRLUT[ttCubeOut] := @CubeOut;
  FQRLUT[ttCubeInOut] := @CubeInOut;
  FQRLUT[ttQuartIn] := @QuartIn;
  FQRLUT[ttQuartOut] := @QuartOut;
  FQRLUT[ttQuartInOut] := @QuartInOut;
  FQRLUT[ttQuintIn] := @QuintIn;
  FQRLUT[ttQuintOut] := @QuintOut;
  FQRLUT[ttQuintInOut] := @QuintInOut;
  FQRLUT[ttSineIn] := @SineIn;
  FQRLUT[ttSineOut] := @SineOut;
  FQRLUT[ttSineInOut] := @SineInOut;
  FQRLUT[ttExpoIn] := @ExpoIn;
  FQRLUT[ttExpoOut] := @ExpoOut;
  FQRLUT[ttExpoInOut] := @ExpoInOut;
*/  
  FQRLUT[ttLinear]       := @Linear;
  FQRLUT[ttQuadOut]      := @QuadOut;
  FQRLUT[ttQuadIn]       := @QuadIn;
  FQRLUT[ttQuadInOut]    := @QuadInOut;
  FQRLUT[ttQuadOutIn]    := @QuadOutIn;
  FQRLUT[ttExpoOut]      := @ExpoOut;
  FQRLUT[ttExpoIn]       := @ExpoIn;
  FQRLUT[ttExpoInOut]    := @ExpoInOut;
  FQRLUT[ttExpoOutIn]    := @ExpoOutIn;
  FQRLUT[ttCubicOut]     := @CubicOut;
  FQRLUT[ttCubicIn]      := @CubicIn;
  FQRLUT[ttCubicInOut]   := @CubicInOut;
  FQRLUT[ttCubicOutIn]   := @CubicOutIn;
  FQRLUT[ttQuartOut]     := @QuartOut;
  FQRLUT[ttQuartIn]      := @QuartIn;
  FQRLUT[ttQuartInOut]   := @QuartInOut;
  FQRLUT[ttQuartOutIn]   := @QuartOutIn;
  FQRLUT[ttQuintOut]     := @QuintOut;
  FQRLUT[ttQuintIn]      := @QuintIn;
  FQRLUT[ttQuintInOut]   := @QuintInOut;
  FQRLUT[ttQuintOutIn]   := @QuintOutIn;
  FQRLUT[ttCircOut]      := @CircOut;
  FQRLUT[ttCircIn]       := @CircIn;
  FQRLUT[ttCircInOut]    := @CircInOut;
  FQRLUT[ttCircOutIn]    := @CircOutIn;
  FQRLUT[ttSineOut]      := @SineOut;
  FQRLUT[ttSineIn]       := @SineIn;
  FQRLUT[ttSineInOut]    := @SineInOut;
  FQRLUT[ttSineOutIn]    := @SineOutIn;
  FQRLUT[ttElasticOut]   := @ElasticOut;
  FQRLUT[ttElasticIn]    := @ElasticIn;
  FQRLUT[ttElasticInOut] := @ElasticInOut;
  FQRLUT[ttElasticOutIn] := @ElasticOutIn;
  FQRLUT[ttBounceOut]    := @BounceOut;
  FQRLUT[ttBounceIn]     := @BounceIn;
  FQRLUT[ttBounceInOut]  := @BounceInOut;
  FQRLUT[ttBounceOutIn]  := @BounceOutIn;
  FQRLUT[ttBackOut]      := @BackOut;
  FQRLUT[ttBackIn]       := @BackIn;
  FQRLUT[ttBackInOut]    := @BackInOut;
  FQRLUT[ttBackOutIn]    := @BackOutIn;
end;

Destructor TW3Tween.Destroy;
begin
  FTimer.free;
  Cancel;
  Clear;
  inherited;
end;

procedure TW3Tween.Clear;
begin
  While FValues.Count>0 do
  begin
    var LIndex := FValues.Count-1;
    var LObj := FValues[LIndex];
    if LObj<>NIL then
    begin
      FValues.delete(LIndex,1);
      LObj.free;
    end;
  end;
  FNameLUT := TVariant.CreateObject;
end;

class function TW3Tween.TimeCode:float;
begin
  asm
    @result = Date.now();
  end;
end;

procedure TW3Tween.TweenResumed(const Item:TW3TweenElement);
begin
  if assigned(Item.OnResumed) then
  Item.OnResumed(Item);
end;

procedure TW3Tween.SetInterval(Const Value:Integer);
begin
  FInterval := TInteger.EnsureRange(Value,1,10000);
end;

procedure TW3Tween.TweenPaused(const Item:TW3TweenElement);
begin
  if assigned(Item.OnPaused) then
  Item.OnPaused(Item);
end;

procedure TW3Tween.TweenComplete(const Item:TW3TweenElement);
begin
  if assigned(Item.OnFinished) then
  Item.OnFinished(Item);
end;

procedure TW3Tween.TweenStarted(const Item:TW3TweenElement);
begin
  if assigned(Item.OnStarted) then
  Item.OnStarted(Item);
end;

function TW3Tween.Update(const Item:TW3TweenElement):Float;
var
  LTotal: float;
begin
  if not Item.Expired then
  begin
    LTotal := FQRLUT[item.AnimationType](TimeCode-Item.StartTime,
                      Item.StartValue,
                      Item.Distance,
                      Item.Duration);
  end else
  if Item.behavior = tbSingle then
  begin
    LTotal := Item.StartValue + Item.Distance;
  end else
  if Item.behavior = tbRepeat then
  begin
    Item.StartTime := TimeCode;
    LTotal := FQRLUT[item.AnimationType](TimeCode-Item.StartTime,
                      Item.StartValue,
                      Item.Distance,
                      Item.Duration);
  end else
  if Item.behavior = tbOscillate then
  begin
    Item.StartValue := Item.StartValue + Item.Distance;
    Item.Distance := -Item.Distance;
    Item.StartTime := TimeCode;
    LTotal := FQRLUT[item.AnimationType](TimeCode-Item.StartTime,
                      Item.StartValue,
                      Item.Distance,
                      Item.Duration);
    Item.State := tsDone;
  end;

  result := Round( LTotal * 100) / 100;
end;

procedure TW3Tween.HandleUpdateTimer(Sender:TObject);
var
  LItem:  TW3TweenElement;
  LCount: Integer;
  LDone:  Integer;
begin
  (* Tween objects cleared while active? *)
  if FValues.Length<1 then
  begin
    Cancel;
    exit;
  end;

  LCount := 0;
  LDone  := 0;
  for LItem in FValues do
  begin
    (* The start time-code is set in the first update *)
    if LItem.State=tsIdle then
    begin
      LItem.State := tsRunning;
      TweenStarted(LItem);
      LItem.StartTime := TimeCode;
    end;

    // Animation paused? Continue with next
    if LItem.State = tsPaused then
    continue;

    // Expired? Keep track of it
    if LItem.Expired then
    begin
      if IgnoreOscillate then
      begin
        //if (LItem.Behavior <> tbOscillate) then
        if (LItem.Behavior = tbSingle) then
        inc(LCount) else
        inc(LDone);
      end else
      inc(LCount);
    end;

    // Update the element with the new value
    LItem.Update(Update(LItem));

    // finished on this run?
    if LItem.Expired then
    begin
      if not Litem.State = tsDone then
      begin
        LItem.State := tsDone;
        TweenComplete(LItem);
      end;
    end;

  end;

  if assigned(OnUpdated) then
  OnUpdated(Self);

  if LCount = (FValues.Length - LDone) then
  begin
    if IgnoreOscillate then
    begin
      if not FPartial then
      begin
        FPartial := True; // make sure this happens only once!
        if assigned(OnPartialFinished) then
        OnPartialFinished(self);
      end;
    end;
  end;

  (* If all tweens have expired, stop the animation *)
  If LCount = FValues.Length then
  begin
    Cancel;
  end;
end;

Procedure TW3Tween.HandleSyncUpdate;
begin
  HandleUpdateTimer(NIL);
  if Active then
  W3_RequestAnimationFrame(HandleSyncUpdate);
end;

procedure TW3Tween.Execute(Const TweenObjects:Array of TW3TweenElement);
var
  LItem:  TW3TweenElement;
  LId:    String;
begin
  if not Active then
  begin
    if TweenObjects.length<0 then
    begin
      for LItem in TweenObjects do
      begin
        LId := LItem.Id.Trim;
        if LId.length>0 then
        begin

          if self.IndexOf(LId)<0 then
          begin
            // Add to LUT
            FNameLUT[LItem.Id] := LItem;
            FValues.add(LItem);
          end else
          Raise EW3TweenError.CreateFmt(CNT_TWEEN_EXEC_EXISTS_ID,[LId]);
        end else
        Raise EW3TweenError.Create(CNT_TWEEN_EXEC_FAILED_ID);
      end;
    end;

    Execute;

  end else
  raise EW3TweenError.Create(CNT_TWEEN_EXEC_BUSY);
end;

procedure TW3Tween.Execute(Finished:TProcedureRef);
begin
  self.OnFinished := procedure (sender:Tobject)
    begin
      if assigned(Finished) then
      Finished;
    end;
  Execute;
end;

procedure TW3Tween.Execute;
begin
  if not Active then
  begin

    FPartial := false;

    case SyncRefresh of
    true:
      begin
        // Initiate loop in 100ms
        W3_SetTimeOut( procedure ()
          begin
            W3_RequestAnimationFrame( HandleSyncUpdate );
          end, 100);
      end;
    false:
      begin
        FTimer.OnTime := HandleUpdateTimer;
        FTimer.Delay := Interval;
        FTimer.Enabled := true;
      end;
    end;

    FActive := True;
    if assigned(OnStarted) then
    OnStarted(self);

  end else
  raise EW3TweenError.Create(CNT_TWEEN_EXEC_BUSY);
end;

procedure TW3Tween.Delete(const TweenIds:Array of String);
var
  Lid:  String;
  LObj: TW3TweenElement;
  LIndex: Integer;
begin
  if tweenIds.length>0 then
  begin
    // Only remove tweens defined in Parameter list
    for LId in Tweenids do
    begin
      LObj := ObjectOf(Lid);
      if LObj<>NIL then
      begin
        LIndex := FValues.IndexOf(LObj);
        FValues.Delete(LIndex,1);
        asm
          delete (@self).FNameLut[@LId];
        end;
        LObj.free;
      end;
    end;
  end;
end;

Procedure TW3Tween.Resume(const index:Integer);
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if (Index>=0) and (Index<FValues.Count) then
    begin
      LObj := FValues[index];
      if LObj.State=tsPaused then
      begin
        LObj.StartTime := TimeCode;
        LObj.State := tsRunning;
        TweenResumed(LObj);
      end;
    end;
  end;
end;

procedure TW3Tween.Resume(const Tween:TW3TweenElement);
begin
  if Active then
  Begin
    if Tween<>NIL then
    Begin
      if FValues.IndexOf(Tween)>=0 then
      begin
        if Tween.state=tsPaused then
        begin
          Tween.State := tsRunning;
          Tween.StartTime := TimeCode;
          TweenResumed(Tween);
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Resume(const Objs:Array of TW3TweenElement);
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if Objs.length>0 then
    Begin
      for LObj in Objs do
      begin
        if LObj<>NIl then
        begin

          if LObj.State=tsPaused then
          begin
            LObj.state := tsRunning;
            LObj.StartTime := TimeCode;
            TweenResumed(LObj);
          end;

        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Resume(const Ids:Array of String);
var
  LId:  String;
begin
  if Active then
  begin
    for LId in Ids do
    begin
      var LObj := ObjectOf(Lid);
      if LObj<>NIL then
      Begin
        if LObj.State = tsPaused then
        begin
          LObj.State := tsRunning;
          LObj.StartTime := TimeCode;
          TweenResumed(LObj);
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Resume;
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if FValues.length>0 then
    Begin
      for LObj in FValues do
      begin
        if LObj<>NIl then
        begin

          if LObj.state=tsPaused then
          begin
            LObj.State := tsRunning;
            LObj.StartTime := TimeCode;
            TweenResumed(LObj);
          end;

        end;
      end;
    end;
  end;
end;

Procedure TW3Tween.Pause(const Index:Integer);
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if (Index>=0) and (Index<FValues.Count) then
    begin
      LObj := FValues[index];
      if LObj.State=tsRunning then
      begin
        LObj.State := tsPaused;
        TweenPaused(LObj);
      end;
    end;
  end;
end;

procedure TW3Tween.Pause(const Tween:TW3TweenElement);
begin
  if Active then
  Begin
    if Tween<>NIL then
    Begin
      if FValues.IndexOf(Tween)>=0 then
      begin
        if Tween.state=tsRunning then
        begin
          Tween.State := tsPaused;
          TweenPaused(Tween);
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Pause(const Objs:Array of TW3TweenElement);
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if Objs.length>0 then
    Begin
      for LObj in Objs do
      begin
        if LObj<>NIl then
        begin
          if LObj.State = tsRunning then
          begin
            LObj.State := tsPaused;
            TweenPaused(LObj);
          end;
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Pause(const Ids:Array of String);
var
  LId:  String;
begin
  if Active then
  begin
    for LId in Ids do
    begin
      var LObj := ObjectOf(LId);
      if LObj<>NIL then
      begin
        if LObj.State = tsRunning then
        begin
          LObj.State := tsPaused;
          TweenPaused(LObj);
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Pause;
var
  LObj: TW3TweenElement;
begin
  if Active then
  begin
    if FValues.length>0 then
    Begin
      for LObj in FValues do
      begin
        if LObj.State = tsRunning then
        begin
          LObj.State := tsPaused;
          TweenPaused(LObj);
        end;
      end;
    end;
  end;
end;

procedure TW3Tween.Cancel;
begin
  if Active then
  begin
    try
      FTimer.enabled := false;
      FTimer.OnTime := NIL;
    finally
      FActive := false;

      if assigned(OnFinished) then
      OnFinished(self);
    end;
  end;
end;

Procedure TW3Tween.Delete(index:Integer);
var
  LObj: TW3TweenElement;
  LId:  String;
begin
  if (index>=0) and (index<FValues.count) then
  begin
    LObj:=FValues[index];
    LId := LObj.id;
    FValues.Delete(Index,1);

    asm
      delete (@self).FNameLUT[@LId];
    end;

    LObj.free;
  end;
end;

procedure TW3Tween.Delete(Id:String);
begin
  Delete(FValues.indexOf(ObjectOf(Id)));
end;

function TW3Tween.Add(const Instance:TW3TweenElement):TW3TweenElement;
begin
  result := Instance;
  if Instance<>NIL then
  begin
    if FValues.IndexOf(Instance)<0 then
    begin
      var id := Instance.id.trim.lowercase;
      if id.length>0 then
      begin
        if IndexOf(id)>=0 then
        begin
          FNameLUT[Instance.Id] := Instance;
          FValues.Add(Instance);
        end else
        Raise EW3TweenError.CreateFmt(CNT_ERR_TWEEN_ELEMENT_DUPLICATE_ID,[Id]);
      end else
      Raise EW3TweenError.Create(CNT_ERR_TWEEN_ELEMENT_EMPTY_ID);
    end else
    Raise EW3TweenError.CreateFmt(CNT_ERR_TWEEN_ELEMENT_EXISTS,[Instance.Id]);
  end;
end;

function TW3Tween.Add(Id:String):TW3TweenElement;
begin
  Id := id.trim.lowercase;
  if id.length>0 then
  begin
    if IndexOf(Id)<0 then
    begin
      result := TW3TweenElement.Create;
      result.Id := Id;
      FNameLUT[Id] := result;
      FValues.add(result);
    end else
    raise EW3TweenError.CreateFmt(CNT_ERR_TWEEN_ELEMENT_DUPLICATE_ID,[Id]);
  end else
  raise EW3TweenError.Create(CNT_ERR_TWEEN_ELEMENT_EMPTY_ID);
end;

Function TW3Tween.Add(Id:String;const aStartValue,aDistance,aDuration:float;
          const aAnimationType:TW3TweenAnimationType;
          const aBehavior:TW3TweenBehavior):TW3TweenElement;
begin
  Id := id.trim.lowercase;
  if id.length>0 then
  begin
    if IndexOf(Id)<0 then
    begin
      result := TW3TweenElement.Create;
      result.StartValue := aStartValue;
      result.Distance := aDistance;
      result.Duration := aDuration;
      result.AnimationType := aAnimationtype;
      result.Behavior := aBehavior;
      result.StartTime := TimeCode;
      result.Id := Id;
      FNameLUT[Id] := result;
      FValues.add(result);
    end else
    raise EW3TweenError.CreateFmt(CNT_ERR_TWEEN_ELEMENT_DUPLICATE_ID,[Id]);
  end else
  raise EW3TweenError.Create(CNT_ERR_TWEEN_ELEMENT_EMPTY_ID);
end;

function TW3Tween.IndexOf(Id:String):Integer;
var
  x:  Integer;
begin
  result := -1;
  id := Id.trim.lowercase;
  if id.length>0 then
  begin
    for x:=0 to FValues.Count-1 do
    begin
      if Id.EqualsText(FValues[x].Id) then
      begin
        result := x;
        break;
      end;
    end;
  end;
end;

function TW3Tween.ObjectOf(const Id:String):TW3TweenElement;
begin
  var ref := FNameLUT[id.trim.tolower];
  asm
    @result = @ref;
  end;
end;

{$HINTS OFF}
{
  Variables for all equations:
  ===========================
  T = Current time (in milliseconds)
  B = Starting value.
  C = Final value
  D = Duration of animation (in milliseconds);
}

{ Easing fx for a simple linear tweening, with no easing. }

function TW3Tween.Linear(T, B, C, D: Float): Float;
begin
  Result := C * T / D + B;
end;

{ Easing fx for an exponential (2^t) easing out:
  decelerating from zero velocity. }

function TW3Tween.ExpoOut(T, B, C, D: Float): Float;
begin
  if (T = D) then
    Result := B + C
  else
    Result := C * (-Power(2, -10 * T / D) + 1) + B;
end;

{ Easing fx for an exponential (2^t) easing in:
  accelerating from zero velocity. }

function TW3Tween.ExpoIn(T, B, C, D: Float): Float;
begin
  if (T = 0) then
    Result := B
  else
    Result := (C * Power(2, 10 * (T / D - 1)) + B);
end;

{ Easing fx for an exponential (2^t) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.ExpoInOut(T, B, C, D: Float): Float;
begin
  if (T = 0) then
    Result := B
  else if (T = D) then
    Result := B + C
  else
  begin
    T := T / (D / 2);
    if (T < 1) then
      Result := C / 2 * Power(2, 10 * (T - 1)) + B
    else
    begin
      T := T - 1;
      Result := C / 2 * (-Power(2, -10 * T) + 2) + B;
    end;
  end;
end;

{ Easing fx for an exponential (2^t) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.ExpoOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := ExpoOut(T * 2, B, C / 2, D)
  else
    Result := ExpoIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a circular (sqrt(1-t^2)) easing out:
  decelerating from zero velocity. }

function TW3Tween.CircOut(T, B, C, D: Float): Float;
begin
  T := T / D - 1;
  Result := C * Sqrt(1 - T * T) + B;
end;

{ Easing fx for a circular (sqrt(1-t^2)) easing in:
  accelerating from zero velocity. }

function TW3Tween.CircIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := -C * (Sqrt(1 - T * T) - 1) + B;
end;

{ Easing fx for a circular (sqrt(1-t^2)) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.CircInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := -C / 2 * (Sqrt(1 - T * T) - 1) + B
  else
  begin
    T := T - 2;
    Result := C / 2 * (Sqrt(1 - T * T) + 1) + B;
  end;
end;

{ Easing fx for a circular (sqrt(1-t^2)) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.CircOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := CircOut(T * 2, B, C / 2, D)
  else
    Result := CircIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a quadratic (t^2) easing out:
  decelerating from zero velocity. }

function TW3Tween.QuadOut(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := -C * T * (T - 2) + B;
end;

{ Easing fx for a quadratic (t^2) easing in:
  accelerating from zero velocity. }

function TW3Tween.QuadIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := C * T * T + B;
end;

{ Easing fx for a quadratic (t^2) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.QuadInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * T * T + B
  else
  begin
    T := T - 1;
    Result := -C / 2 * (T * (T - 2) - 1) + B;
  end;
end;

{ Easing fx for a quadratic (t^2) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.QuadOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := QuadOut(T * 2, B, C / 2, D)
  else
    Result := QuadIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a sinusoidal (sin(t)) easing out:
  decelerating from zero velocity. }

function TW3Tween.SineOut(T, B, C, D: Float): Float;
begin
  Result := C * Sin(T / D * (PI / 2)) + B;
end;

{ Easing fx for a sinusoidal (sin(t)) easing in:
  accelerating from zero velocity. }

function TW3Tween.SineIn(T, B, C, D: Float): Float;
begin
  Result := -C * Cos(T / D * (PI / 2)) + C + B;
end;

{ Easing fx for a sinusoidal (sin(t)) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.SineInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * (Sin(PI * T / 2)) + B
  else
  begin
    T := T - 1;
    Result := -C / 2 * (Cos(PI * T / 2) - 2) + B;
  end;
end;

{ Easing fx for a sinusoidal (sin(t)) easing in/out:
  deceleration until halfway,then acceleration. }

function TW3Tween.SineOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := SineOut(T * 2, B, C / 2, D)
  else
    Result := SineIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a cubic (t^3) easing out:
  decelerating from zero velocity. }

function TW3Tween.CubicOut(T, B, C, D: Float): Float;
begin
  T := T / D - 1;
  Result := C * (T * T * T + 1) + B;
end;

{ Easing fx for a cubic (t^3) easing in:
  accelerating from zero velocity. }

function TW3Tween.CubicIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := C * T * T * T + B;
end;

{ Easing fx for a cubic (t^3) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.CubicInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * T * T * T + B
  else
  begin
    T := T - 2;
    Result := C / 2 * (T * T * T + 2) + B;
  end;
end;

{ Easing fx for a cubic (t^3) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.CubicOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := CubicOut(T * 2, B, C / 2, D)
  else
    Result := CubicIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a quartic (t^4) easing out:
  decelerating from zero velocity. }

function TW3Tween.QuartOut(T, B, C, D: Float): Float;
begin
  T := T / D - 1;
  Result := -C * (T * T * T * T - 1) + B;
end;

{ Easing fx for a quartic (t^4) easing in:
  accelerating from zero velocity. }

function TW3Tween.QuartIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := C * T * T * T * T + B;
end;

{ Easing fx for a quartic (t^4) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.QuartInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * T * T * T * T + B
  else
  begin
    T := T - 2;
    Result := -C / 2 * (T * T * T * T - 2) + B;
  end;
end;

{ Easing fx for a quartic (t^4) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.QuartOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := QuartOut(T * 2, B, C / 2, D)
  else
    Result := QuartIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a quintic (t^5) easing out:
  decelerating from zero velocity. }

function TW3Tween.QuintOut(T, B, C, D: Float): Float;
begin
  T := T / D - 1;
  Result := C * (T * T * T * T * T + 1) + B;
end;

{ Easing fx for a quintic (t^5) easing in:
  accelerating from zero velocity. }

function TW3Tween.QuintIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := C * T * T * T * T * T + B;
end;

{ Easing fx for a quintic (t^5) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.QuintInOut(T, B, C, D: Float): Float;
begin
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * T * T * T * T * T + B
  else
  begin
    T := T - 2;
    Result := C / 2 * (T * T * T * T * T + 2) + B;
  end;
end;

{ Easing fx for a quintic (t^5) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.QuintOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := QuintOut(T * 2, B, C / 2, D)
  else
    Result := QuintIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for an elastic (exponentially decaying sine wave) easing out:
  decelerating from zero velocity. }

function TW3Tween.ElasticOut(T, B, C, D: Float): Float;
var
  P, S: Float;
begin
  T := T / D;
  if (T = 1) then
    Result := B + C
  else
  begin
    P := D * 0.3;
    S := P / 4;
    Result := (C * Power(2, -10 * T) * Sin((T * D - S) * (2 * PI) / P) + C + B);
  end;
end;

{ Easing fx for an elastic (exponentially decaying sine wave) easing in:
  accelerating from zero velocity. }

function TW3Tween.ElasticIn(T, B, C, D: Float): Float;
var
  P, S: Float;
begin
  T := T / D;
  if (T = 1) then
    Result := B + C
  else
  begin
    P := D * 0.3;
    S := P / 4;
    T := T - 1;
    Result := -(C * Power(2, 10 * T) * Sin((T * D - S) * (2 * PI) / P)) + B;
  end;
end;

{ Easing fx for an elastic (exponentially decaying sine wave) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.ElasticInOut(T, B, C, D: Float): Float;
var
  P, S: Float;
begin
  T := T / (D / 2);
  if (T = 2) then
    Result := B + C
  else
  begin
    P := D * (0.3 * 1.5);
S := P / 4;
if (T < 1) then
begin
  T := T - 1;
  Result := -0.5 * (C * Power(2, 10 * T) * Sin((T * D - S) * (2 * PI) / P)) + B;
end
else
begin
  T := T - 1;
  Result := C * Power(2, -10 * T) * Sin((T * D - S) * (2 * PI) / P) * 0.5 + C +
    B;
end;
end;
end;

{ Easing fx for an elastic (exponentially decaying sine wave) easing out/in:
 deceleration until halfway,then acceleration. }

function TW3Tween.ElasticOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := ElasticOut(T * 2, B, C / 2, D)
  else
    Result := ElasticIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a bounce (exponentially decaying parabolic bounce) easing out:
  decelerating from zero velocity. }

function TW3Tween.BounceOut(T, B, C, D: Float): Float;
begin
  T := T / D;
  if (T < (1 / 2.75)) then
    Result := C * (7.5625 * T * T) + B
  else if (T < (2 / 2.75)) then
  begin
    T := T - (1.5 / 2.75);
    Result := C * (7.5625 * T * T + 0.75) + B;
  end
  else if (T < (2.5 / 2.75)) then
  begin
    T := T - (2.25 / 2.75);
    Result := C * (7.5625 * T * T + 0.9375) + B;
  end
  else
  begin
    T := T - (2.625 / 2.75);
    Result := C * (7.5625 * T * T + 0.984375) + B;
  end;
end;

{ Easing fx for a bounce (exponentially decaying parabolic bounce) easing in:
  accelerating from zero velocity. }

function TW3Tween.BounceIn(T, B, C, D: Float): Float;
begin
  Result := C - BounceOut(D - T, 0, C, D) + B;
end;

{ Easing fx for a bounce (exponentially decaying parabolic bounce) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.BounceInOut(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := BounceIn(T * 2, 0, C, D) * 0.5 + B
  else
    Result := BounceOut(T * 2 - D, 0, C, D) * 0.5 + C * 0.5 + B;
end;

{ Easing fx for a bounce (exponentially decaying parabolic bounce) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.BounceOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := BounceOut(T * 2, B, C / 2, D)
  else
    Result := BounceIn((T * 2) - D, B + C / 2, C / 2, D);
end;

{ Easing fx for a back (overshooting cubic easing: (s+1)*t^3-s*t^2) easing out:
  decelerating from zero velocity. }

function TW3Tween.BackOut(T, B, C, D: Float): Float;
begin
  T := T / D - 1;
  Result := C * (T * T * ((1.70158 + 1) * T + 1.70158) + 1) + B;
end;

{ Easing fx for a back (overshooting cubic easing: (s+1)*t^3-s*t^2) easing in:
  accelerating from zero velocity. }

function TW3Tween.BackIn(T, B, C, D: Float): Float;
begin
  T := T / D;
  Result := C * T * T * ((1.70158 + 1) * T - 1.70158) + B;
end;

{ Easing fx for a back (overshooting cubic easing: (s+1)*t^3-s*t^2) easing in/out:
  acceleration until halfway,then deceleration. }

function TW3Tween.BackInOut(T, B, C, D: Float): Float;
var
  S: Float;
begin
  S := 1.70158 * 1.525;
  T := T / (D / 2);
  if (T < 1) then
    Result := C / 2 * (T * T * ((S + 1) * T - S)) + B
  else
  begin
    T := T - 2;
    Result := C / 2 * (T * T * ((S + 1) * T + S) + 2) + B;
  end;
end;

{ Easing fx for a back (overshooting cubic easing: (s+1)*t^3-s*t^2) easing out/in:
  deceleration until halfway,then acceleration. }

function TW3Tween.BackOutIn(T, B, C, D: Float): Float;
begin
  if (T < D / 2) then
    Result := BackOut(T * 2, B, C / 2, D)
  else
    Result := BackIn((T * 2) - D, B + C / 2, C / 2, D);
end;
//---------------- END EASING FUNCTIONS ----------------------------------------
/*
function TW3Tween.ExpoIn(t, b, c, d:float):float;
begin
  result := c * power(2,10 * (t/d-1))+b;
end;

function TW3Tween.ExpoOut(t, b, c, d:float):float;
begin
  result := c * (-power(2,-10 * t/d)+1)+b;
end;

function TW3Tween.ExpoInOut(t, b, c, d:float):float;
begin
 if (t=0) then  // by warleyalex
    Result:=b
 else if (t=d) then
    Result:=b+c
 else
    begin
    t:=t/(d/2);
    if (t < 1) then
       Result:=c/2*Power(2,10*(t-1))+b
    else
       begin
       t:=t-1;
       Result:=c/2*(-Power(2,-10*t)+2)+b;
       end;
    end;
{
  t := t / ( d / 2);
  if (t<1) then
  begin
    result := c/2 * power(2,10 * (t-1)) + b;
  end else
  begin
    t:=t-1;
    result := c/2 * (power(2,-10*t)+2)+b;
  end;
}
end;

function TW3Tween.SineIn(t, b, c, d:float):float;
begin
  result := -c * cos(t/d * (PI / 2)) + c + b;
end;

function TW3Tween.SineOut(t, b, c, d:float):float;
begin
  //result := c * cos(t/d * (PI / 2)) + b;  // warleyalex
  Result:=c*Sin(t/d*(PI/2))+b;
end;

function TW3Tween.SineInOut(t, b, c, d:float):float;
begin
  result := -c / 2 * (cos( PI * t / d) -1) + b;
end;

function TW3Tween.QuintIn(t, b, c, d:float):float;
begin
  t := t / d;
  result := c*t*t*t*t*t+b
end;

function TW3Tween.QuintOut(t, b, c, d:float):float;
begin
  t := t / d;
  t := t -1;
  result := c * (t*t*t*t*t+1) + b;
end;

function TW3Tween.QuintInOut(t, b, c, d:float):float;
begin
  t := t / (d / 2);
  if (t<1) then
  begin
    result := c/2 * t * t * t * t * t + b;
  end else
  begin
    t:=t-2;
    result := c/2 * (t*t*t*t*t+2) +b;
  end;
end;

function TW3Tween.QuartIn(t, b, c, d:float):float;
begin
  t := t / d;
  result := c * t * t * t * t + b;
end;

function TW3Tween.QuartOut(t, b, c, d:float):float;
begin
  t := t / d;
  t := t - 1;
  result := -c * (t * t * t * t - 1) + b;
end;

function TW3Tween.QuartInOut(t, b, c, d:float):float;
begin
  t := t / (d/2);
  if (t<1) then
  begin
    result := c/2 * t * t * t * t + b;
  end else
  begin
    t := t - 2;
    result := -c / 2 * (t * t * t * t - 2) + b;
  end;
end;

function TW3Tween.CubeInOut(t, b, c, d:float):float;
begin
  t := t / (d / 2);
  if ( t < 1) then
  begin
    result := c / 2 * (t * t * t) + b;
  end else
  begin
    t := t -2;
    result := c/2 * (t*t*t + 2) + b;
  end;
end;

function TW3Tween.CubeOut(t, b, c, d:float):float;
begin
  t := t / d;
  t := t - 1;
  result := c * (t * t * t + 1) + b;
end;

function TW3Tween.CubeIn(t, b, c, d:float):float;
begin
  t := t / d;
  result := c * t * t * t + b;
end;

function TW3Tween.QuadInOut(t, b, c, d:float):float;
begin
  t := t / (d / 2);
  if (t<1) then
  begin
    result := c / 2 * t * t + b;
    exit;
  end else
  begin
    t := t -1;
    result := -c / 2 * (t * (t - 2) -1) + b;
  end;
end;

function TW3Tween.QuadOut(t, b, c, d:float):float;
begin
  t := t / d;
  result := -c * t * (t - 2) + b;
end;

function TW3Tween.QuadIn(t, b, c, d:float):float;
begin
  t := t / d;
  result := c * t * t + b;
end;

function TW3Tween.Linear(t,b,c,d:float):float;
begin
  result := c * t / d + b;
end;
*/
{$HINTS ON}

//############################################################################
// TW3TweenData
//############################################################################

function TW3TweenData.Expired: Boolean;
begin
  result := StartTime + Duration < TW3Tween.TimeCode;
end;

Procedure TW3TweenData.Reset;
begin
  StartTime := 0;
  StartValue := 0;
  Distance := 0;
  Duration := 0;
  Animationtype := ttLinear;
  Behavior := tbSingle;
end;

//############################################################################
// TW3TweenElement
//############################################################################

Constructor TW3TweenElement.Create;
begin
  inherited Create;
  State := tsIdle;
end;

Procedure TW3TweenElement.Reset;
begin
  inherited Reset;
  State := tsIdle;
end;

procedure TW3TweenElement.Update(const aValue:Float);
begin
  Value := aValue;
  if assigned(OnUpdated) then
  OnUpdated(self);
end;

end.
