unit Form486;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm486 = class(TW3Form)
  private
    {$I 'Form486:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm486 }

procedure TForm486.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm486.InitializeObject;
begin
  inherited;
  {$I 'Form486:impl'}
end;
 
procedure TForm486.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm486);
end.
