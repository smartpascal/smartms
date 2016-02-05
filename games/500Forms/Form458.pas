unit Form458;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm458 = class(TW3Form)
  private
    {$I 'Form458:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm458 }

procedure TForm458.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm458.InitializeObject;
begin
  inherited;
  {$I 'Form458:impl'}
end;
 
procedure TForm458.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm458);
end.
