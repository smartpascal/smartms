unit Form158;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm158 = class(TW3Form)
  private
    {$I 'Form158:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm158 }

procedure TForm158.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm158.InitializeObject;
begin
  inherited;
  {$I 'Form158:impl'}
end;
 
procedure TForm158.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm158);
end.
