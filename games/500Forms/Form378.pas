unit Form378;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm378 = class(TW3Form)
  private
    {$I 'Form378:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm378 }

procedure TForm378.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm378.InitializeObject;
begin
  inherited;
  {$I 'Form378:impl'}
end;
 
procedure TForm378.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm378);
end.
