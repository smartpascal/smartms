unit Form3;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button,
  SmartCL.Controls.Label,
  SmartCL.Layout;

type
  TForm3 = class(TW3Form)
  private
    {$I 'Form3:intf'}
    FLayout: TLayout;
    procedure W3Button1Click(Sender: TObject);
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure FormDeactivated; override;
    procedure Resize; override;
  end;

implementation

{ TForm3 }

procedure TForm3.W3Button1Click(Sender: TObject);
begin
	Application.GotoForm('Form1', feFromRight{feToLeft});
end;

procedure TForm3.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
  fLayout:= Layout.Client(Layout.Margins(10),
                          [Layout.Top(W3Label1),
                          Layout.Bottom(Layout.Height(50),
                                        Layout.Right(W3Button1)
                                        )]
                         );
end;

procedure TForm3.InitializeObject;
begin
  inherited;
  {$I 'Form3:impl'}
end;
 
procedure TForm3.Resize;
begin
  inherited;
  if assigned(FLayout) then
    FLayout.Resize(self);
end;
 
procedure TForm3.FormDeactivated;
begin
  inherited;
  WriteLn('FormDeactivated3');
  //FLayout := nil;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm3);
end.
