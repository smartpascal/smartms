unit Form233;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm233 = class(TW3Form)
  private
    {$I 'Form233:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm233 }

procedure TForm233.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm233.InitializeObject;
begin
  inherited;
  {$I 'Form233:impl'}
end;
 
procedure TForm233.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm233);
end.
