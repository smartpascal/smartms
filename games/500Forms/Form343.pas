unit Form343;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm343 = class(TW3Form)
  private
    {$I 'Form343:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm343 }

procedure TForm343.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm343.InitializeObject;
begin
  inherited;
  {$I 'Form343:impl'}
end;
 
procedure TForm343.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm343);
end.
