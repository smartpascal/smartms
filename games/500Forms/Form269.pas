unit Form269;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm269 = class(TW3Form)
  private
    {$I 'Form269:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm269 }

procedure TForm269.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm269.InitializeObject;
begin
  inherited;
  {$I 'Form269:impl'}
end;
 
procedure TForm269.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm269);
end.
