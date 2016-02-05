unit Form496;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm496 = class(TW3Form)
  private
    {$I 'Form496:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm496 }

procedure TForm496.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm496.InitializeObject;
begin
  inherited;
  {$I 'Form496:impl'}
end;
 
procedure TForm496.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm496);
end.
