unit Form133;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm133 = class(TW3Form)
  private
    {$I 'Form133:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm133 }

procedure TForm133.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm133.InitializeObject;
begin
  inherited;
  {$I 'Form133:impl'}
end;
 
procedure TForm133.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm133);
end.
