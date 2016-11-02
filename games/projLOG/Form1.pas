unit Form1;

interface

uses 
  uLogin,
  W3C.HTML5, W3C.Console,
  mORMotClient, SynCrossPlatformREST,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application,
  SmartCL.Controls.Elements, SmartCL.Controls.Button;

type
  THandleArray = array of variant;


type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    Login1: TLogin;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

var Client : TSQLRestClientURI;

implementation

{ TForm1 }

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
/* ---------------------------------------------------------------------------- */
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}

  Login1 := TLogin.Create(Self);

  Login1.OnClickLogin := lambda(Sender: TObject)
    WriteLn('OnClickLogin was clicked!');
    Application.GotoForm('Form2');
  end;

  Login1.OnClickLogout := lambda(Sender: TObject)
    WriteLn('OnClickLogout was clicked!');
  end;

  Login1.OnClickRegister := lambda(Sender: TObject)
    WriteLn('OnClickRegister was clicked!');
  end;

  Login1.OnClickRegisterNow := lambda(Sender: TObject)
    WriteLn('OnClickRegisterNow was clicked!');
  end;

  Login1.OnClickForgotPW := lambda(Sender: TObject)
    WriteLn('OnClickForgotPW was clicked!');
  end;

  Login1.OnClickRememberPW := lambda(Sender: TObject)
    WriteLn('OnClickRememberPW was clicked!');
  end;

end;
 
procedure TForm1.Resize;
begin
  inherited;

end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
  
end.
