unit Form341;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm341 = class(TW3Form)
  private
    {$I 'Form341:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm341 }

procedure TForm341.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm341.InitializeObject;
begin
  inherited;
  {$I 'Form341:impl'}
end;
 
procedure TForm341.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm341);
end.
