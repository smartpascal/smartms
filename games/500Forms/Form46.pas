unit Form46;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm46 = class(TW3Form)
  private
    {$I 'Form46:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm46 }

procedure TForm46.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm46.InitializeObject;
begin
  inherited;
  {$I 'Form46:impl'}
end;
 
procedure TForm46.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm46);
end.
