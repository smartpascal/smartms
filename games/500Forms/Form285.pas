unit Form285;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm285 = class(TW3Form)
  private
    {$I 'Form285:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm285 }

procedure TForm285.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm285.InitializeObject;
begin
  inherited;
  {$I 'Form285:impl'}
end;
 
procedure TForm285.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm285);
end.
