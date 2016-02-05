unit Form75;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm75 = class(TW3Form)
  private
    {$I 'Form75:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm75 }

procedure TForm75.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm75.InitializeObject;
begin
  inherited;
  {$I 'Form75:impl'}
end;
 
procedure TForm75.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm75);
end.
