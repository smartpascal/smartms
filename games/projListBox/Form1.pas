unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, System.Colors,
  uMyListBox, SmartCL.Controls.Listbox, SmartCL.Controls.Button,
  SmartCL.Controls.Label, SmartCL.Controls.SimpleLabel,
  SmartCL.Controls.EditBox;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    MyListBox1 : TMyListBox;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure DeleteFrom(listbox: TW3ListBox);
    function GetTextChild(lb: TW3ListBox; idx: integer): TW3Label;
    procedure AddItem(Name: string);
  end;

implementation

{ TForm1 }

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components

end;

procedure TForm1.AddItem(Name: string);
begin
  var item := W3ListBox1[W3ListBox1.Add];
  var lbl := TW3SimpleLabel.Create(item);
  lbl.StyleClass := 'TW3SimpleLabel';
  lbl.Font.Name := "'Arial Black', arial, sans-serif";
  lbl.Font.Color := clBlue;
  lbl.Caption := name;
  lbl.Autosize := false;
  w3_setStyle(lbl.Handle, 'text-align', 'center');
  lbl.SetBounds(0, 0, item.ClientWidth, item.ClientHeight);
end;


procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
(*--------------------------------------*)
  MyListBox1 := TMyListBox.Create(self);
  MyListBox1.SetBounds(8,60,304,176);
  MyListBox1.Styles.SelectedColor := clLime;
  MyListBox1.Styles.HighlightedColor := clAquamarine;
  MyListBox1.Styles.MovingColor := clBurlyWood;
  MyListBox1.AllowMoving := true;
  W3btnLB1Add.OnClick := procedure(sender: TObject)
  begin
    MyListBox1.Add('- ' + IntToStr(MyListBox1.Count) + ' -');
    MyListBox1.GetTextChild(MyListBox1.Count-1).Container.Font.Name :=
      "'Arial Black', arial, sans-serif";
    MyListBox1.GetTextChild(MyListBox1.Count-1).AlignText := taCenter;
    MyListBox1.GetTextChild(MyListBox1.Count-1).Container.Font.Color := clBlue;
  end;
  W3btnLB1Delete.OnClick := lambda DeleteFrom(MyListBox1); end;

(*-----------*)
  W3listbox1.Styles.SelectedColor := clLime;
  W3listbox1.Styles.HighlightedColor := clAquamarine;
  W3listbox1.Styles.MovingColor := clBurlyWood;
  W3listbox1.AllowMoving := true;
  B1Delete.OnClick := lambda DeleteFrom(W3listbox1); end;
  B1Add.OnClick := lambda  AddItem(IntToStr(W3listbox1.Count));  end;

end;
 
procedure TForm1.DeleteFrom(listbox: TW3ListBox);
begin
  if listbox.SelectedIndex >= 0 then
    listbox.Delete(listbox.SelectedIndex);
end;

function TForm1.GetTextChild(lb: TW3ListBox; idx: integer): TW3Label;
begin
  Result := nil;
  var item := lb.Items[idx];
  for var iChild := 0 to item.GetChildCount - 1 do begin
    var obj := item.GetChildObject(iChild);
    if Assigned(obj) and (obj is TW3Label) then
      Exit(TW3Label(obj));
  end;
end;

procedure TForm1.Resize;
begin
  inherited;

end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.