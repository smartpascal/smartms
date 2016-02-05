unit Form134;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm134 = class(TW3Form)
  private
    {$I 'Form134:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm134 }

procedure TForm134.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm134.InitializeObject;
begin
  inherited;
  {$I 'Form134:impl'}
end;
 
procedure TForm134.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm134);
end.
