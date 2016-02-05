unit Form299;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm299 = class(TW3Form)
  private
    {$I 'Form299:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm299 }

procedure TForm299.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm299.InitializeObject;
begin
  inherited;
  {$I 'Form299:impl'}
end;
 
procedure TForm299.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm299);
end.
