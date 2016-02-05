unit Form208;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm208 = class(TW3Form)
  private
    {$I 'Form208:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm208 }

procedure TForm208.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm208.InitializeObject;
begin
  inherited;
  {$I 'Form208:impl'}
end;
 
procedure TForm208.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm208);
end.
