unit Unit1;

interface

uses
  W3C.HTML5, W3C.DOM, W3C.Console, ECMA.JSON,
  System.Types, SmartCL.System,
  SmartCL.Forms, SmartCL.MiniApplication,
  SmartCL.Components,
  Form1, Form2, Form3, Form4;


type
  TApp = class(TCustomApplication)
  private
    //Sender: TDIVContainer;
  protected
    procedure ApplicationStarting; override;
  end;

{ ╔═══════════════════════════════════════╗
  ║ TDIVContainer :: Render Forms on DIV  ║
  ╚═══════════════════════════════════════╝ }
/*
type
  TDIVContainer = class(TW3Component)
  private
    class var _instance: TDIVContainer;
  published
    class function Instance: TDIVContainer;
    procedure RegisterPageName(pageName: string);
  end;

  JNodeSelector = class external "Object"
    function querySelector(selectors: string): JElement;
  end;
*/
implementation

{ ╔═════════════════════════════════════╗
  ║ TDIVContainer :: SingleTon Class    ║
  ╚═════════════════════════════════════╝ }
/*
class function TDIVContainer.Instance: TDIVContainer;
begin
  if _instance = nil then
    _instance := TDIVContainer.Create(nil);
  result:= _instance;
end;

procedure TDIVContainer.RegisterPageName(pageName: string);
begin
  Self.Handle := JNodeSelector(document).querySelector('.swiper-container').firstElementChild;
end;
*/
procedure TApp.ApplicationStarting;
var
  mForm: TW3CustomForm;
begin

 (* Render forms on a DIV. This is a Singleton class, a single instance is fine *)
//  Sender := TDIVContainer.Instance;
//  Sender.RegisterPageName('about');


	mForm := TForm1.Create(Display);
	mForm.name := 'Form1';
  //mForm.StyleClass := 'swiper-slide TW3CustomForm';
  //mForm.Handle.classList.add("swiper-slide", "TW3CustomForm");
	//RegisterFormInstance(mForm, true);


 	mForm := TForm2.Create(Display);
	mForm.name := 'Form2';
  //mForm.StyleClass := 'swiper-slide TW3CustomForm';
  //mForm.Handle.classList.add("swiper-slide", "TW3CustomForm");
	//RegisterFormInstance(mForm, false);

	mForm:=TForm3.Create(Display);
	mForm.name:= 'Form3';
  //mForm.StyleClass := 'swiper-slide TW3CustomForm';
  //mForm.Handle.classList.add("swiper-slide", "TW3CustomForm");
	//RegisterFormInstance(mForm, false);

	mForm:=TForm4.Create(Display);
	mForm.name:= 'Form4';
  //mForm.StyleClass := 'swiper-slide TW3CustomForm';
  //mForm.Handle.classList.add("swiper-slide", "TW3CustomForm");
	//RegisterFormInstance(mForm, false);

  inherited;
end;

end.