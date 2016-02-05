unit Form249;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm249 = class(TW3Form)
  private
    {$I 'Form249:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm249 }

procedure TForm249.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm249.InitializeObject;
begin
  inherited;
  {$I 'Form249:impl'}
end;
 
procedure TForm249.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm249);
end.
