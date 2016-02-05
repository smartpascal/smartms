unit Form211;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm211 = class(TW3Form)
  private
    {$I 'Form211:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm211 }

procedure TForm211.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm211.InitializeObject;
begin
  inherited;
  {$I 'Form211:impl'}
end;
 
procedure TForm211.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm211);
end.
