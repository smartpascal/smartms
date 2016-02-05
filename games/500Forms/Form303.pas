unit Form303;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm303 = class(TW3Form)
  private
    {$I 'Form303:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm303 }

procedure TForm303.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm303.InitializeObject;
begin
  inherited;
  {$I 'Form303:impl'}
end;
 
procedure TForm303.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm303);
end.
