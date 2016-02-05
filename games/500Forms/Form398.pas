unit Form398;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm398 = class(TW3Form)
  private
    {$I 'Form398:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm398 }

procedure TForm398.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm398.InitializeObject;
begin
  inherited;
  {$I 'Form398:impl'}
end;
 
procedure TForm398.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm398);
end.
