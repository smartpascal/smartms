unit Form215;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm215 = class(TW3Form)
  private
    {$I 'Form215:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm215 }

procedure TForm215.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm215.InitializeObject;
begin
  inherited;
  {$I 'Form215:impl'}
end;
 
procedure TForm215.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm215);
end.
