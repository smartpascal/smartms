unit Form447;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm447 = class(TW3Form)
  private
    {$I 'Form447:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm447 }

procedure TForm447.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm447.InitializeObject;
begin
  inherited;
  {$I 'Form447:impl'}
end;
 
procedure TForm447.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm447);
end.
