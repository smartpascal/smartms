unit Form77;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm77 = class(TW3Form)
  private
    {$I 'Form77:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm77 }

procedure TForm77.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm77.InitializeObject;
begin
  inherited;
  {$I 'Form77:impl'}
end;
 
procedure TForm77.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm77);
end.
