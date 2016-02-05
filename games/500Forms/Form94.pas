unit Form94;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm94 = class(TW3Form)
  private
    {$I 'Form94:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm94 }

procedure TForm94.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm94.InitializeObject;
begin
  inherited;
  {$I 'Form94:impl'}
end;
 
procedure TForm94.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm94);
end.
