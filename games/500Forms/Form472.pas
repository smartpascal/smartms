unit Form472;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm472 = class(TW3Form)
  private
    {$I 'Form472:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm472 }

procedure TForm472.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm472.InitializeObject;
begin
  inherited;
  {$I 'Form472:impl'}
end;
 
procedure TForm472.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm472);
end.
