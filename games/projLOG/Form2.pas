unit Form2;

interface

uses 
  W3C.Console,
  Form1, mORMotClient,
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button,
  SmartCL.Controls.Elements, SmartCL.Controls.EditBox;

type
  TForm2 = class(TW3Form)
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    {$I 'Form2:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm2 }

procedure TForm2.btn2Click(Sender: TObject);
begin

end;

procedure TForm2.btn3Click(Sender: TObject);
begin

end;

procedure TForm2.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm2.InitializeObject;
begin
  inherited;
  {$I 'Form2:impl'}
   div1.Handle.id := 'div1';
   div1.InnerHTML :=
      #'<svg class="sms__app__logout-icon svg-icon" viewBox="0 0 20 20">
          <path d="M6,3 a8,8 0 1,0 8,0 M10,0 10,12"/>
        </svg>';


  Handle.ReadyExecute(procedure()
  begin
    SMS("#div1").css(CLASS
     "background":= "#FC3768";
     "border-radius":= "50%";
    END);

    SMS(document).on("click", "#div1", function(e: JFramework7EventObject): variant
    begin
      SMS(".sms__md").click();
      Application.GotoForm('Form1',feToLeft);
      console.log('logout');
    end);
  end);

end;
 
procedure TForm2.Resize;
begin
  inherited;

end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm2);
end.
