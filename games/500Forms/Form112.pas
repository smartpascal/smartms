unit Form112;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm112 = class(TW3Form)
  private
    {$I 'Form112:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm112 }

procedure TForm112.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm112.InitializeObject;
begin
  inherited;
  {$I 'Form112:impl'}
end;
 
procedure TForm112.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm112);
end.
