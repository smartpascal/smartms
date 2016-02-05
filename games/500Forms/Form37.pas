unit Form37;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm37 = class(TW3Form)
  private
    {$I 'Form37:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm37 }

procedure TForm37.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm37.InitializeObject;
begin
  inherited;
  {$I 'Form37:impl'}
end;
 
procedure TForm37.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm37);
end.
