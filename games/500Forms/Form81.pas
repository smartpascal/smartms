unit Form81;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm81 = class(TW3Form)
  private
    {$I 'Form81:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm81 }

procedure TForm81.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm81.InitializeObject;
begin
  inherited;
  {$I 'Form81:impl'}
end;
 
procedure TForm81.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm81);
end.
