unit Form448;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm448 = class(TW3Form)
  private
    {$I 'Form448:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm448 }

procedure TForm448.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm448.InitializeObject;
begin
  inherited;
  {$I 'Form448:impl'}
end;
 
procedure TForm448.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm448);
end.
