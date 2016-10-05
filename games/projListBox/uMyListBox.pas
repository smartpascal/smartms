unit uMyListBox;

interface

uses
  SmartCL.System, SmartCL.Controls.ListBox, SmartCL.Controls.Label;

type
  TMyListBox = class(TW3ListBox)
  public
    function GetTextChild(idx: integer): TW3Label;
  end;

implementation

function TMyListBox.GetTextChild(idx: integer): TW3Label;
begin
  Result := nil;
  var item := Items[idx];
  for var iChild := 0 to item.GetChildCount - 1 do begin
    var obj := item.GetChildObject(iChild);
    if Assigned(obj) and (obj is TW3Label) then
      Exit(TW3Label(obj));
  end;
end;

end.