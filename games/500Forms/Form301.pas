unit Form301;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm301 = class(TW3Form)
  private
    {$I 'Form301:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm301 }

procedure TForm301.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm301.InitializeObject;
begin
  inherited;
  {$I 'Form301:impl'}
end;
 
procedure TForm301.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm301);
end.
