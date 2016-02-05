unit Form310;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm310 = class(TW3Form)
  private
    {$I 'Form310:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm310 }

procedure TForm310.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm310.InitializeObject;
begin
  inherited;
  {$I 'Form310:impl'}
end;
 
procedure TForm310.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm310);
end.
