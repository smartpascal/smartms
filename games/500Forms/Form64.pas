unit Form64;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm64 = class(TW3Form)
  private
    {$I 'Form64:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm64 }

procedure TForm64.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm64.InitializeObject;
begin
  inherited;
  {$I 'Form64:impl'}
end;
 
procedure TForm64.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm64);
end.
