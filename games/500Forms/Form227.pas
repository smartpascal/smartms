unit Form227;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm227 = class(TW3Form)
  private
    {$I 'Form227:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm227 }

procedure TForm227.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm227.InitializeObject;
begin
  inherited;
  {$I 'Form227:impl'}
end;
 
procedure TForm227.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm227);
end.
