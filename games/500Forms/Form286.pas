unit Form286;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm286 = class(TW3Form)
  private
    {$I 'Form286:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm286 }

procedure TForm286.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm286.InitializeObject;
begin
  inherited;
  {$I 'Form286:impl'}
end;
 
procedure TForm286.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm286);
end.
