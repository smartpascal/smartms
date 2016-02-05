unit Form460;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm460 = class(TW3Form)
  private
    {$I 'Form460:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm460 }

procedure TForm460.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm460.InitializeObject;
begin
  inherited;
  {$I 'Form460:impl'}
end;
 
procedure TForm460.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm460);
end.
