unit Form253;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm253 = class(TW3Form)
  private
    {$I 'Form253:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm253 }

procedure TForm253.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm253.InitializeObject;
begin
  inherited;
  {$I 'Form253:impl'}
end;
 
procedure TForm253.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm253);
end.
