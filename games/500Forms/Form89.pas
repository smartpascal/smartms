unit Form89;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm89 = class(TW3Form)
  private
    {$I 'Form89:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm89 }

procedure TForm89.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm89.InitializeObject;
begin
  inherited;
  {$I 'Form89:impl'}
end;
 
procedure TForm89.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm89);
end.
