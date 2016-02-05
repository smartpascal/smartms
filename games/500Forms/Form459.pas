unit Form459;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm459 = class(TW3Form)
  private
    {$I 'Form459:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm459 }

procedure TForm459.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm459.InitializeObject;
begin
  inherited;
  {$I 'Form459:impl'}
end;
 
procedure TForm459.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm459);
end.
