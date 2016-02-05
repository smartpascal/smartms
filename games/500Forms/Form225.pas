unit Form225;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm225 = class(TW3Form)
  private
    {$I 'Form225:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm225 }

procedure TForm225.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm225.InitializeObject;
begin
  inherited;
  {$I 'Form225:impl'}
end;
 
procedure TForm225.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm225);
end.
