unit Form421;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm421 = class(TW3Form)
  private
    {$I 'Form421:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm421 }

procedure TForm421.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm421.InitializeObject;
begin
  inherited;
  {$I 'Form421:impl'}
end;
 
procedure TForm421.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm421);
end.
