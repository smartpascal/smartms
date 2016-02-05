unit Form66;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm66 = class(TW3Form)
  private
    {$I 'Form66:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm66 }

procedure TForm66.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm66.InitializeObject;
begin
  inherited;
  {$I 'Form66:impl'}
end;
 
procedure TForm66.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm66);
end.
