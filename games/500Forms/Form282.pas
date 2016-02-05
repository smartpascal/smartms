unit Form282;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm282 = class(TW3Form)
  private
    {$I 'Form282:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm282 }

procedure TForm282.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm282.InitializeObject;
begin
  inherited;
  {$I 'Form282:impl'}
end;
 
procedure TForm282.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm282);
end.
