unit Form240;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm240 = class(TW3Form)
  private
    {$I 'Form240:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm240 }

procedure TForm240.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm240.InitializeObject;
begin
  inherited;
  {$I 'Form240:impl'}
end;
 
procedure TForm240.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm240);
end.
