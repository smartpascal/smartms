unit Form433;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm433 = class(TW3Form)
  private
    {$I 'Form433:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm433 }

procedure TForm433.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm433.InitializeObject;
begin
  inherited;
  {$I 'Form433:impl'}
end;
 
procedure TForm433.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm433);
end.
