unit Form179;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm179 = class(TW3Form)
  private
    {$I 'Form179:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm179 }

procedure TForm179.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm179.InitializeObject;
begin
  inherited;
  {$I 'Form179:impl'}
end;
 
procedure TForm179.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm179);
end.
