unit Form34;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm34 = class(TW3Form)
  private
    {$I 'Form34:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm34 }

procedure TForm34.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm34.InitializeObject;
begin
  inherited;
  {$I 'Form34:impl'}
end;
 
procedure TForm34.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm34);
end.
