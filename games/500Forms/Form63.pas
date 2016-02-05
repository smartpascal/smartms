unit Form63;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm63 = class(TW3Form)
  private
    {$I 'Form63:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm63 }

procedure TForm63.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm63.InitializeObject;
begin
  inherited;
  {$I 'Form63:impl'}
end;
 
procedure TForm63.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm63);
end.
