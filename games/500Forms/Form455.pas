unit Form455;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm455 = class(TW3Form)
  private
    {$I 'Form455:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm455 }

procedure TForm455.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm455.InitializeObject;
begin
  inherited;
  {$I 'Form455:impl'}
end;
 
procedure TForm455.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm455);
end.
