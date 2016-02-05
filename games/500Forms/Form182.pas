unit Form182;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm182 = class(TW3Form)
  private
    {$I 'Form182:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm182 }

procedure TForm182.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm182.InitializeObject;
begin
  inherited;
  {$I 'Form182:impl'}
end;
 
procedure TForm182.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm182);
end.
