unit Form403;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm403 = class(TW3Form)
  private
    {$I 'Form403:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm403 }

procedure TForm403.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm403.InitializeObject;
begin
  inherited;
  {$I 'Form403:impl'}
end;
 
procedure TForm403.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm403);
end.
