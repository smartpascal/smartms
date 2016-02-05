unit Form207;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm207 = class(TW3Form)
  private
    {$I 'Form207:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm207 }

procedure TForm207.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm207.InitializeObject;
begin
  inherited;
  {$I 'Form207:impl'}
end;
 
procedure TForm207.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm207);
end.
