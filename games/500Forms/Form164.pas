unit Form164;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm164 = class(TW3Form)
  private
    {$I 'Form164:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm164 }

procedure TForm164.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm164.InitializeObject;
begin
  inherited;
  {$I 'Form164:impl'}
end;
 
procedure TForm164.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm164);
end.
