unit Form464;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm464 = class(TW3Form)
  private
    {$I 'Form464:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm464 }

procedure TForm464.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm464.InitializeObject;
begin
  inherited;
  {$I 'Form464:impl'}
end;
 
procedure TForm464.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm464);
end.
