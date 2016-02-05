unit Form150;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm150 = class(TW3Form)
  private
    {$I 'Form150:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm150 }

procedure TForm150.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm150.InitializeObject;
begin
  inherited;
  {$I 'Form150:impl'}
end;
 
procedure TForm150.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm150);
end.
