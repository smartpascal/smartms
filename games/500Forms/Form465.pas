unit Form465;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm465 = class(TW3Form)
  private
    {$I 'Form465:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm465 }

procedure TForm465.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm465.InitializeObject;
begin
  inherited;
  {$I 'Form465:impl'}
end;
 
procedure TForm465.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm465);
end.
