unit Form186;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm186 = class(TW3Form)
  private
    {$I 'Form186:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm186 }

procedure TForm186.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm186.InitializeObject;
begin
  inherited;
  {$I 'Form186:impl'}
end;
 
procedure TForm186.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm186);
end.
