unit Form116;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm116 = class(TW3Form)
  private
    {$I 'Form116:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm116 }

procedure TForm116.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm116.InitializeObject;
begin
  inherited;
  {$I 'Form116:impl'}
end;
 
procedure TForm116.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm116);
end.
