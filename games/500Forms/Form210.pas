unit Form210;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm210 = class(TW3Form)
  private
    {$I 'Form210:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm210 }

procedure TForm210.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm210.InitializeObject;
begin
  inherited;
  {$I 'Form210:impl'}
end;
 
procedure TForm210.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm210);
end.
