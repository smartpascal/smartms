unit Form238;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm238 = class(TW3Form)
  private
    {$I 'Form238:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm238 }

procedure TForm238.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm238.InitializeObject;
begin
  inherited;
  {$I 'Form238:impl'}
end;
 
procedure TForm238.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm238);
end.
