unit Form250;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm250 = class(TW3Form)
  private
    {$I 'Form250:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm250 }

procedure TForm250.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm250.InitializeObject;
begin
  inherited;
  {$I 'Form250:impl'}
end;
 
procedure TForm250.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm250);
end.
