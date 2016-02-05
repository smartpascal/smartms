unit Form333;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm333 = class(TW3Form)
  private
    {$I 'Form333:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm333 }

procedure TForm333.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm333.InitializeObject;
begin
  inherited;
  {$I 'Form333:impl'}
end;
 
procedure TForm333.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm333);
end.
