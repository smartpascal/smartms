unit Form204;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm204 = class(TW3Form)
  private
    {$I 'Form204:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm204 }

procedure TForm204.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm204.InitializeObject;
begin
  inherited;
  {$I 'Form204:impl'}
end;
 
procedure TForm204.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm204);
end.
