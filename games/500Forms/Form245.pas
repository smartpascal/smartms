unit Form245;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm245 = class(TW3Form)
  private
    {$I 'Form245:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm245 }

procedure TForm245.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm245.InitializeObject;
begin
  inherited;
  {$I 'Form245:impl'}
end;
 
procedure TForm245.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm245);
end.
