unit Form82;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm82 = class(TW3Form)
  private
    {$I 'Form82:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm82 }

procedure TForm82.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm82.InitializeObject;
begin
  inherited;
  {$I 'Form82:impl'}
end;
 
procedure TForm82.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm82);
end.
