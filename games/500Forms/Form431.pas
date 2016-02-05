unit Form431;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm431 = class(TW3Form)
  private
    {$I 'Form431:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm431 }

procedure TForm431.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm431.InitializeObject;
begin
  inherited;
  {$I 'Form431:impl'}
end;
 
procedure TForm431.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm431);
end.
