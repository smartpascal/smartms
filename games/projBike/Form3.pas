unit Form3;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm3 = class(TW3Form)
  private
    {$I 'Form3:intf'}
    Component3: TW3CustomControl;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm3 }

procedure TForm3.InitializeForm;
begin
  inherited;

end;

procedure TForm3.InitializeObject;
begin
  inherited;
  {$I 'Form3:impl'}
(* COMPONENT 3 *)
  Component3 := TW3CustomControl.create(self);
  Component3.SetBounds(0,0,Self.ClientWidth, Self.ClientHeight);
  Component3.Handle.id := 'component3';
  Component3.Handle.className := '';

  Component3.Handle.ReadyExecute(procedure()
  begin
    Component3.Handle.style["width"] := null;
    Component3.Handle.style["height"] := null;
    Component3.Handle.style["width"] := '100%';
    Component3.SendToBack;
  end);

end;
 
procedure TForm3.Resize;
begin
  inherited;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm3);
end.
