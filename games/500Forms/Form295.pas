unit Form295;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm295 = class(TW3Form)
  private
    {$I 'Form295:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm295 }

procedure TForm295.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm295.InitializeObject;
begin
  inherited;
  {$I 'Form295:impl'}
end;
 
procedure TForm295.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm295);
end.
