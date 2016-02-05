unit Form304;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm304 = class(TW3Form)
  private
    {$I 'Form304:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm304 }

procedure TForm304.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm304.InitializeObject;
begin
  inherited;
  {$I 'Form304:impl'}
end;
 
procedure TForm304.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm304);
end.
