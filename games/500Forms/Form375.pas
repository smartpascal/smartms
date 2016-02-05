unit Form375;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm375 = class(TW3Form)
  private
    {$I 'Form375:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm375 }

procedure TForm375.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm375.InitializeObject;
begin
  inherited;
  {$I 'Form375:impl'}
end;
 
procedure TForm375.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm375);
end.
