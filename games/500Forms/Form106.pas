unit Form106;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm106 = class(TW3Form)
  private
    {$I 'Form106:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm106 }

procedure TForm106.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm106.InitializeObject;
begin
  inherited;
  {$I 'Form106:impl'}
end;
 
procedure TForm106.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm106);
end.
