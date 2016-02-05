unit Form416;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm416 = class(TW3Form)
  private
    {$I 'Form416:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm416 }

procedure TForm416.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm416.InitializeObject;
begin
  inherited;
  {$I 'Form416:impl'}
end;
 
procedure TForm416.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm416);
end.
