unit Form108;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm108 = class(TW3Form)
  private
    {$I 'Form108:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm108 }

procedure TForm108.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm108.InitializeObject;
begin
  inherited;
  {$I 'Form108:impl'}
end;
 
procedure TForm108.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm108);
end.
