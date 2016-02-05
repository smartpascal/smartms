unit Form479;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm479 = class(TW3Form)
  private
    {$I 'Form479:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm479 }

procedure TForm479.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm479.InitializeObject;
begin
  inherited;
  {$I 'Form479:impl'}
end;
 
procedure TForm479.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm479);
end.
