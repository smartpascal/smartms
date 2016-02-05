unit Form205;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm205 = class(TW3Form)
  private
    {$I 'Form205:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm205 }

procedure TForm205.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm205.InitializeObject;
begin
  inherited;
  {$I 'Form205:impl'}
end;
 
procedure TForm205.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm205);
end.
