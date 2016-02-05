unit Form217;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm217 = class(TW3Form)
  private
    {$I 'Form217:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm217 }

procedure TForm217.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm217.InitializeObject;
begin
  inherited;
  {$I 'Form217:impl'}
end;
 
procedure TForm217.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm217);
end.
