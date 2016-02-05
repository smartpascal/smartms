unit Form136;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm136 = class(TW3Form)
  private
    {$I 'Form136:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm136 }

procedure TForm136.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm136.InitializeObject;
begin
  inherited;
  {$I 'Form136:impl'}
end;
 
procedure TForm136.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm136);
end.
