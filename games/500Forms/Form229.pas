unit Form229;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm229 = class(TW3Form)
  private
    {$I 'Form229:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm229 }

procedure TForm229.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm229.InitializeObject;
begin
  inherited;
  {$I 'Form229:impl'}
end;
 
procedure TForm229.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm229);
end.
