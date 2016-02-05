unit Form270;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm270 = class(TW3Form)
  private
    {$I 'Form270:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm270 }

procedure TForm270.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm270.InitializeObject;
begin
  inherited;
  {$I 'Form270:impl'}
end;
 
procedure TForm270.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm270);
end.
