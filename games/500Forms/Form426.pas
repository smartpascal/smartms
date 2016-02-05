unit Form426;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm426 = class(TW3Form)
  private
    {$I 'Form426:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm426 }

procedure TForm426.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm426.InitializeObject;
begin
  inherited;
  {$I 'Form426:impl'}
end;
 
procedure TForm426.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm426);
end.
