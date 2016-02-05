unit Form256;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm256 = class(TW3Form)
  private
    {$I 'Form256:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm256 }

procedure TForm256.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm256.InitializeObject;
begin
  inherited;
  {$I 'Form256:impl'}
end;
 
procedure TForm256.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm256);
end.
