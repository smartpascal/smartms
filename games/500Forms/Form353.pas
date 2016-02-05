unit Form353;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm353 = class(TW3Form)
  private
    {$I 'Form353:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm353 }

procedure TForm353.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm353.InitializeObject;
begin
  inherited;
  {$I 'Form353:impl'}
end;
 
procedure TForm353.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm353);
end.
