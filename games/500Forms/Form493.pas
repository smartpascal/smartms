unit Form493;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm493 = class(TW3Form)
  private
    {$I 'Form493:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm493 }

procedure TForm493.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm493.InitializeObject;
begin
  inherited;
  {$I 'Form493:impl'}
end;
 
procedure TForm493.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm493);
end.
