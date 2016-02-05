unit Form191;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm191 = class(TW3Form)
  private
    {$I 'Form191:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm191 }

procedure TForm191.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm191.InitializeObject;
begin
  inherited;
  {$I 'Form191:impl'}
end;
 
procedure TForm191.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm191);
end.
