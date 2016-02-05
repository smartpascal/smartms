unit Form380;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm380 = class(TW3Form)
  private
    {$I 'Form380:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm380 }

procedure TForm380.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm380.InitializeObject;
begin
  inherited;
  {$I 'Form380:impl'}
end;
 
procedure TForm380.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm380);
end.
