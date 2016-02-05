unit Form115;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm115 = class(TW3Form)
  private
    {$I 'Form115:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm115 }

procedure TForm115.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm115.InitializeObject;
begin
  inherited;
  {$I 'Form115:impl'}
end;
 
procedure TForm115.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm115);
end.
