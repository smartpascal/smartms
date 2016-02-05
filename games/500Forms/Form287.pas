unit Form287;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm287 = class(TW3Form)
  private
    {$I 'Form287:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm287 }

procedure TForm287.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm287.InitializeObject;
begin
  inherited;
  {$I 'Form287:impl'}
end;
 
procedure TForm287.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm287);
end.
