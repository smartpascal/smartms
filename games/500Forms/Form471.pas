unit Form471;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm471 = class(TW3Form)
  private
    {$I 'Form471:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm471 }

procedure TForm471.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm471.InitializeObject;
begin
  inherited;
  {$I 'Form471:impl'}
end;
 
procedure TForm471.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm471);
end.
