unit Form119;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm119 = class(TW3Form)
  private
    {$I 'Form119:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm119 }

procedure TForm119.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm119.InitializeObject;
begin
  inherited;
  {$I 'Form119:impl'}
end;
 
procedure TForm119.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm119);
end.
