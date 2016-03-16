unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button,
  SmartCL.Layout,
  SmartCL.Controls.Label,
  Form3, SmartCL.Controls.Memo;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    FLayout: TLayout;
    procedure W3Button1Click(Sender: TObject);
    procedure W3Button2Click(Sender: TObject);
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormDeactivated; override;	
  end;

implementation

{ TForm1 }

procedure TForm1.W3Button2Click(Sender: TObject);
begin
  // third form is not created automatically
/*
  if not assigned(FForm3) then begin
    FForm3 := TForm3.Create(Application.Display.View);
    FForm3.Name := 'Form3';
    Application.RegisterFormInstance(FForm3, true);
  end;
*/
  // as we know the address of the form object, we can use GotoFormByRef
	//Application.GotoFormByRef(FForm3, feFromRight);
  Application.GotoForm('Form3', feFromRight);
end;

procedure TForm1.W3Button1Click(Sender: TObject);
begin
	Application.GotoForm('Form2', feFromRight);
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
  W3Memo1.Text := #"
    Second form (Form2) is automatically created by the RTL. It uses SmartCL.Layout to position components.

    Third form (Form3) is manually created in the code (TForm1.W3Button2Click).";
  W3Memo1.Enabled := false;

  FLayout:= Layout.Client(Layout.Margins(10),
                          [Layout.Top(W3Label1),
                          Layout.Top(Layout.Stretch, W3Memo1),
                          Layout.Bottom(Layout.Height(50),
                                        Layout.Right(Layout.Spacing(3),[W3Button1, W3Button2] )
                                        )]
                         );
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
end;
 
procedure TForm1.Resize;
begin
  inherited;
  if assigned(FLayout) then
    FLayout.Resize(self);
end;
 
 procedure TForm1.FormDeactivated;
begin
  inherited;
  //FLayout := nil;
  WriteLn('FormDeactivated1');
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.