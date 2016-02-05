unit Form261;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm261 = class(TW3Form)
  private
    {$I 'Form261:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm261 }

procedure TForm261.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm261.InitializeObject;
begin
  inherited;
  {$I 'Form261:impl'}
end;
 
procedure TForm261.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm261);
end.
