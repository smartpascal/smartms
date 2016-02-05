unit Form332;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm332 = class(TW3Form)
  private
    {$I 'Form332:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm332 }

procedure TForm332.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm332.InitializeObject;
begin
  inherited;
  {$I 'Form332:impl'}
end;
 
procedure TForm332.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm332);
end.
