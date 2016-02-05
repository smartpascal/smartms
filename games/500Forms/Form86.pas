unit Form86;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm86 = class(TW3Form)
  private
    {$I 'Form86:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm86 }

procedure TForm86.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm86.InitializeObject;
begin
  inherited;
  {$I 'Form86:impl'}
end;
 
procedure TForm86.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm86);
end.
