unit Form488;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm488 = class(TW3Form)
  private
    {$I 'Form488:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm488 }

procedure TForm488.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm488.InitializeObject;
begin
  inherited;
  {$I 'Form488:impl'}
end;
 
procedure TForm488.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm488);
end.
