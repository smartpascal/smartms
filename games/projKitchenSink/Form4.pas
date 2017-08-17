unit Form4;

interface

uses 
  W3C.HTML5, W3C.DOM, W3C.Console, ECMA.JSON,
  SmartCL.System, System.Types,
  SmartCL.MiniApplication,
  SmartCL.Forms,
  SmartCL.Components, uMDButton;

type
  TForm4 = class(TW3Form)
  private
    {$I 'Form4:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm4 }

procedure TForm4.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm4.InitializeObject;
begin
  inherited;
  {$I 'Form4:impl'}
end;
 
procedure TForm4.Resize;
begin
  inherited;
end;
 
initialization
  //Forms.RegisterForm({$I %FILE%}, TForm4);
end.
