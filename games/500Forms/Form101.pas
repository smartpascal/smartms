unit Form101;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm101 = class(TW3Form)
  private
    {$I 'Form101:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm101 }

procedure TForm101.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm101.InitializeObject;
begin
  inherited;
  {$I 'Form101:impl'}
end;
 
procedure TForm101.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm101);
end.
