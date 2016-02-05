unit Form84;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm84 = class(TW3Form)
  private
    {$I 'Form84:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm84 }

procedure TForm84.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm84.InitializeObject;
begin
  inherited;
  {$I 'Form84:impl'}
end;
 
procedure TForm84.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm84);
end.
