unit Form278;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm278 = class(TW3Form)
  private
    {$I 'Form278:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm278 }

procedure TForm278.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm278.InitializeObject;
begin
  inherited;
  {$I 'Form278:impl'}
end;
 
procedure TForm278.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm278);
end.
