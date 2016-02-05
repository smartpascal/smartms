unit Form200;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm200 = class(TW3Form)
  private
    {$I 'Form200:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm200 }

procedure TForm200.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm200.InitializeObject;
begin
  inherited;
  {$I 'Form200:impl'}
end;
 
procedure TForm200.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm200);
end.
