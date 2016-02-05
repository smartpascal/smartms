unit Form226;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm226 = class(TW3Form)
  private
    {$I 'Form226:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm226 }

procedure TForm226.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm226.InitializeObject;
begin
  inherited;
  {$I 'Form226:impl'}
end;
 
procedure TForm226.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm226);
end.
