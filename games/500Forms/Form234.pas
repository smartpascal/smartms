unit Form234;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm234 = class(TW3Form)
  private
    {$I 'Form234:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm234 }

procedure TForm234.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm234.InitializeObject;
begin
  inherited;
  {$I 'Form234:impl'}
end;
 
procedure TForm234.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm234);
end.
