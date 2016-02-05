unit Form329;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm329 = class(TW3Form)
  private
    {$I 'Form329:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm329 }

procedure TForm329.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm329.InitializeObject;
begin
  inherited;
  {$I 'Form329:impl'}
end;
 
procedure TForm329.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm329);
end.
