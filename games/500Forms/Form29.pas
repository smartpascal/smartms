unit Form29;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm29 = class(TW3Form)
  private
    {$I 'Form29:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm29 }

procedure TForm29.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm29.InitializeObject;
begin
  inherited;
  {$I 'Form29:impl'}
end;
 
procedure TForm29.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm29);
end.
