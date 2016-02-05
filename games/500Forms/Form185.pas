unit Form185;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm185 = class(TW3Form)
  private
    {$I 'Form185:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm185 }

procedure TForm185.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm185.InitializeObject;
begin
  inherited;
  {$I 'Form185:impl'}
end;
 
procedure TForm185.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm185);
end.
