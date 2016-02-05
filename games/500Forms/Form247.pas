unit Form247;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm247 = class(TW3Form)
  private
    {$I 'Form247:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm247 }

procedure TForm247.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm247.InitializeObject;
begin
  inherited;
  {$I 'Form247:impl'}
end;
 
procedure TForm247.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm247);
end.
