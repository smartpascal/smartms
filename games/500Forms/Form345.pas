unit Form345;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm345 = class(TW3Form)
  private
    {$I 'Form345:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm345 }

procedure TForm345.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm345.InitializeObject;
begin
  inherited;
  {$I 'Form345:impl'}
end;
 
procedure TForm345.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm345);
end.
