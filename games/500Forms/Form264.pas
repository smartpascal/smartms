unit Form264;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm264 = class(TW3Form)
  private
    {$I 'Form264:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm264 }

procedure TForm264.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm264.InitializeObject;
begin
  inherited;
  {$I 'Form264:impl'}
end;
 
procedure TForm264.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm264);
end.
