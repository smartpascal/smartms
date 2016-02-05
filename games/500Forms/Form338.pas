unit Form338;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm338 = class(TW3Form)
  private
    {$I 'Form338:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm338 }

procedure TForm338.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm338.InitializeObject;
begin
  inherited;
  {$I 'Form338:impl'}
end;
 
procedure TForm338.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm338);
end.
