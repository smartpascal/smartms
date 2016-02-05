unit Form360;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm360 = class(TW3Form)
  private
    {$I 'Form360:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm360 }

procedure TForm360.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm360.InitializeObject;
begin
  inherited;
  {$I 'Form360:impl'}
end;
 
procedure TForm360.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm360);
end.
