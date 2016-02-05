unit Form320;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm320 = class(TW3Form)
  private
    {$I 'Form320:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm320 }

procedure TForm320.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm320.InitializeObject;
begin
  inherited;
  {$I 'Form320:impl'}
end;
 
procedure TForm320.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm320);
end.
