unit Form265;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm265 = class(TW3Form)
  private
    {$I 'Form265:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm265 }

procedure TForm265.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm265.InitializeObject;
begin
  inherited;
  {$I 'Form265:impl'}
end;
 
procedure TForm265.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm265);
end.
