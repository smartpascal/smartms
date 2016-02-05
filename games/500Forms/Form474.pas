unit Form474;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm474 = class(TW3Form)
  private
    {$I 'Form474:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm474 }

procedure TForm474.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm474.InitializeObject;
begin
  inherited;
  {$I 'Form474:impl'}
end;
 
procedure TForm474.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm474);
end.
