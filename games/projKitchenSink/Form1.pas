unit Form1;

interface

uses 
  W3C.HTML5, W3C.DOM, W3C.Console, ECMA.JSON,
  SmartCL.System, System.Types,
  SmartCL.MiniApplication,
  SmartCL.Forms,
  SmartCL.Components, uMDButton;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}

end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
initialization
  //Forms.RegisterForm({$I %FILE%}, TForm1);
end.
