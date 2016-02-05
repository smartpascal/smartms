unit Form456;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm456 = class(TW3Form)
  private
    {$I 'Form456:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm456 }

procedure TForm456.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm456.InitializeObject;
begin
  inherited;
  {$I 'Form456:impl'}
end;
 
procedure TForm456.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm456);
end.
