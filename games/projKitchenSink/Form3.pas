unit Form3;

interface

uses 
  W3C.HTML5, W3C.DOM, W3C.Console, ECMA.JSON,
  SmartCL.System, System.Types,
  SmartCL.MiniApplication,
  SmartCL.Forms,
  SmartCL.Components, uMDButton;

type
  TForm3 = class(TW3Form)
  private
    {$I 'Form3:intf'}
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
  // this is a good place to initialize components
end;

procedure TForm3.InitializeObject;
begin
  inherited;
  {$I 'Form3:impl'}
end;
 
procedure TForm3.Resize;
begin
  inherited;
end;
 
initialization
  //Forms.RegisterForm({$I %FILE%}, TForm3);
end.
