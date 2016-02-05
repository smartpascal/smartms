unit Form76;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm76 = class(TW3Form)
  private
    {$I 'Form76:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm76 }

procedure TForm76.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm76.InitializeObject;
begin
  inherited;
  {$I 'Form76:impl'}
end;
 
procedure TForm76.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm76);
end.
