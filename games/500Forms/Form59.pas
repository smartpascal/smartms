unit Form59;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm59 = class(TW3Form)
  private
    {$I 'Form59:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm59 }

procedure TForm59.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm59.InitializeObject;
begin
  inherited;
  {$I 'Form59:impl'}
end;
 
procedure TForm59.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm59);
end.
