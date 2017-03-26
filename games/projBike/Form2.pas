unit Form2;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm2 = class(TW3Form)
  private
  {$I 'Form2:intf'}
    Component2: TW3CustomControl;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm2 }

procedure TForm2.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm2.InitializeObject;
begin
  inherited;
  {$I 'Form2:impl'}
(* COMPONENT 2 *)
  Component2 := TW3CustomControl.create(self);
  Component2.SetBounds(0,0,Self.ClientWidth, Self.ClientHeight);
  Component2.Handle.id := 'component2';
  Component2.Handle.className := 'buceta';
  //Component2.StyleClass := 'buceta';
  Component2.Handle.ReadyExecute(procedure()
  begin
    Component2.Handle.style["width"] := null;
    Component2.Handle.style["height"] := null;
    Component2.Handle.style["width"] := '100%';
    Component2.SendToBack;
    //Component2.onclick := teste;
    //teste(Self);
  end);

end;
 
procedure TForm2.Resize;
begin
  inherited;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm2);
end.
