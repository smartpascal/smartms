unit Form412;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm412 = class(TW3Form)
  private
    {$I 'Form412:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm412 }

procedure TForm412.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm412.InitializeObject;
begin
  inherited;
  {$I 'Form412:impl'}
end;
 
procedure TForm412.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm412);
end.
