unit Form2;

interface

uses 
  W3C.HTML5, W3C.DOM, W3C.Console, ECMA.JSON,
  SmartCL.System, System.Types,
  SmartCL.MiniApplication,
  SmartCL.Forms,
  SmartCL.Components, uMDButton;

type
  TForm2 = class(TW3Form)
  private
    {$I 'Form2:intf'}
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
end;
 
procedure TForm2.Resize;
begin
  inherited;
end;
 
initialization
  //Forms.RegisterForm({$I %FILE%}, TForm2);
end.
