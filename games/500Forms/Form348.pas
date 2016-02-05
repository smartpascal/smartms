unit Form348;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm348 = class(TW3Form)
  private
    {$I 'Form348:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm348 }

procedure TForm348.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm348.InitializeObject;
begin
  inherited;
  {$I 'Form348:impl'}
end;
 
procedure TForm348.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm348);
end.
