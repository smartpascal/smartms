unit Form93;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm93 = class(TW3Form)
  private
    {$I 'Form93:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm93 }

procedure TForm93.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm93.InitializeObject;
begin
  inherited;
  {$I 'Form93:impl'}
end;
 
procedure TForm93.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm93);
end.
