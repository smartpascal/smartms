unit Form190;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm190 = class(TW3Form)
  private
    {$I 'Form190:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm190 }

procedure TForm190.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm190.InitializeObject;
begin
  inherited;
  {$I 'Form190:impl'}
end;
 
procedure TForm190.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm190);
end.
