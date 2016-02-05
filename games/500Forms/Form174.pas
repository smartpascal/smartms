unit Form174;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm174 = class(TW3Form)
  private
    {$I 'Form174:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm174 }

procedure TForm174.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm174.InitializeObject;
begin
  inherited;
  {$I 'Form174:impl'}
end;
 
procedure TForm174.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm174);
end.
