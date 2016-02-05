unit Form199;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm199 = class(TW3Form)
  private
    {$I 'Form199:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm199 }

procedure TForm199.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm199.InitializeObject;
begin
  inherited;
  {$I 'Form199:impl'}
end;
 
procedure TForm199.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm199);
end.
