unit Form281;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm281 = class(TW3Form)
  private
    {$I 'Form281:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm281 }

procedure TForm281.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm281.InitializeObject;
begin
  inherited;
  {$I 'Form281:impl'}
end;
 
procedure TForm281.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm281);
end.
