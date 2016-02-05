unit Form142;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm142 = class(TW3Form)
  private
    {$I 'Form142:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm142 }

procedure TForm142.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm142.InitializeObject;
begin
  inherited;
  {$I 'Form142:impl'}
end;
 
procedure TForm142.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm142);
end.
