unit Form277;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm277 = class(TW3Form)
  private
    {$I 'Form277:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm277 }

procedure TForm277.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm277.InitializeObject;
begin
  inherited;
  {$I 'Form277:impl'}
end;
 
procedure TForm277.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm277);
end.
