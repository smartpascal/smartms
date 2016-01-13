unit Input;

interface

uses
  SmartCL.System, Settings;

type
  TCallback = procedure(mCode: Integer);

procedure AddKeyDown(Callback: TCallback);
procedure KeyDownEvent(mCode: Integer);
procedure AddKeyUp(Callback: TCallback);
procedure KeyUpEvent(mCode: Integer);

var
  KeyDownCallbacks, KeyUpCallbacks: Array of TCallback;

implementation

procedure AddKeyDown(Callback: TCallback);
begin
  KeyDownCallbacks.Add(Callback);
end;

procedure KeyDownEvent(mCode: Integer);
var
  I: Integer;
begin
  Log(IntToStr(mCode) + ' down');
  for I := Low(KeyDownCallbacks) to High(KeyDownCallbacks) do begin
    Log('Call ' + IntToStr(I));
    KeyDownCallbacks[I](mCode);
  end;
end;

procedure AddKeyUp(Callback: TCallback);
begin
  KeyUpCallbacks.Add(Callback);
end;

procedure KeyUpEvent(mCode: Integer);
var
  I: Integer;
begin
  Log(IntToStr(mCode) + ' up');
  for I := Low(KeyUpCallbacks) to High(KeyUpCallbacks) do begin
    KeyUpCallbacks[I](mCode);
  end;
end;

end.