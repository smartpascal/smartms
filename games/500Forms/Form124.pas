unit Form124;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm124 = class(TW3Form)
  private
    {$I 'Form124:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm124 }

procedure TForm124.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm124.InitializeObject;
begin
  inherited;
  {$I 'Form124:impl'}
end;
 
procedure TForm124.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm124);
end.
