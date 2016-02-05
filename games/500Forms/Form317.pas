unit Form317;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm317 = class(TW3Form)
  private
    {$I 'Form317:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm317 }

procedure TForm317.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm317.InitializeObject;
begin
  inherited;
  {$I 'Form317:impl'}
end;
 
procedure TForm317.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm317);
end.
