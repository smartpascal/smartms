unit Form379;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm379 = class(TW3Form)
  private
    {$I 'Form379:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm379 }

procedure TForm379.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm379.InitializeObject;
begin
  inherited;
  {$I 'Form379:impl'}
end;
 
procedure TForm379.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm379);
end.
