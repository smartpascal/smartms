unit Form68;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm68 = class(TW3Form)
  private
    {$I 'Form68:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm68 }

procedure TForm68.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm68.InitializeObject;
begin
  inherited;
  {$I 'Form68:impl'}
end;
 
procedure TForm68.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm68);
end.
