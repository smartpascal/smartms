unit Form235;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm235 = class(TW3Form)
  private
    {$I 'Form235:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm235 }

procedure TForm235.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm235.InitializeObject;
begin
  inherited;
  {$I 'Form235:impl'}
end;
 
procedure TForm235.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm235);
end.
