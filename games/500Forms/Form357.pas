unit Form357;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm357 = class(TW3Form)
  private
    {$I 'Form357:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm357 }

procedure TForm357.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm357.InitializeObject;
begin
  inherited;
  {$I 'Form357:impl'}
end;
 
procedure TForm357.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm357);
end.
