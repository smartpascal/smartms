unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, Button, TextField,
  CheckBox, Slider, RadioPanel, Switch, Menu, Header;

type
  TForm1 = class(TW3Form)
    procedure Header1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    {$I 'Form1:intf'}
    procedure ClickSalamander;
    Procedure ClickProc01;
    Procedure ClickProc03;

  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  WriteLn(Button1.Title);
end;

procedure TForm1.Switch1Click(Sender: TObject);
begin
 If Switch1.StateOn then
   WriteLn('Switched On') else
   WriteLn('Switched Off');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Menu1.ShowMenu;
end;

procedure TForm1.Header1Click(Sender: TObject);
begin
  Menu2.ShowMenu;
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  (* Switch1.StateOn default *)
  //  Switch1.StateOn := true;    //default false

(*  AddBranch parameters : text, cheched, clickproc *)
  RadioPanel1.AddRadioButton('All reptiles in the world',false,ClickSalamander);
  RadioPanel1.AddRadioButton('All mammals in the world',true,nil);
  RadioPanel1.AddRadioButton('Other types of animal',false,nil);

  (*  AddMenuItem parameters : text, clickproc  *)
  Menu1.AddMenuItem('Menu choice 01',ClickProc01);
  Menu1.AddMenuItem('Menu choice disabled',nil);
  Menu1.AddMenuItem('Menu choice 03',ClickProc03);

(*  Header Menu Item  *)
  Menu2.AddMenuItem('Menu choice 01',ClickProc01);
  Menu2.AddMenuItem('Menu choice disabled',nil);
  Menu2.AddMenuItem('Menu choice 03',ClickProc01);

end;

procedure TForm1.ClickSalamander;
begin
  WriteLn('Executing Salamander Proc');
end;

procedure TForm1.ClickProc01;
begin
  showmessage('Executing User Proc 01');
end;

procedure TForm1.ClickProc03;
begin
  showmessage('Executing User Proc 03');
end;

procedure TForm1.Resize;
begin
  inherited;
  Header1.Width := Self.Width;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.