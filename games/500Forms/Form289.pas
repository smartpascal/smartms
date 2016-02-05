unit Form289;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm289 = class(TW3Form)
  private
    {$I 'Form289:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm289 }

procedure TForm289.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm289.InitializeObject;
begin
  inherited;
  {$I 'Form289:impl'}
end;
 
procedure TForm289.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm289);
end.
