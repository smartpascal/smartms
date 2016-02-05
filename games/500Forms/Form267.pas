unit Form267;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm267 = class(TW3Form)
  private
    {$I 'Form267:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm267 }

procedure TForm267.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm267.InitializeObject;
begin
  inherited;
  {$I 'Form267:impl'}
end;
 
procedure TForm267.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm267);
end.
