unit Form480;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm480 = class(TW3Form)
  private
    {$I 'Form480:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm480 }

procedure TForm480.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm480.InitializeObject;
begin
  inherited;
  {$I 'Form480:impl'}
end;
 
procedure TForm480.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm480);
end.
