unit Form473;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm473 = class(TW3Form)
  private
    {$I 'Form473:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm473 }

procedure TForm473.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm473.InitializeObject;
begin
  inherited;
  {$I 'Form473:impl'}
end;
 
procedure TForm473.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm473);
end.
