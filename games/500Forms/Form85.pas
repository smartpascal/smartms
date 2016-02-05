unit Form85;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm85 = class(TW3Form)
  private
    {$I 'Form85:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm85 }

procedure TForm85.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm85.InitializeObject;
begin
  inherited;
  {$I 'Form85:impl'}
end;
 
procedure TForm85.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm85);
end.
