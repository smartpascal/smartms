unit Form334;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm334 = class(TW3Form)
  private
    {$I 'Form334:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm334 }

procedure TForm334.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm334.InitializeObject;
begin
  inherited;
  {$I 'Form334:impl'}
end;
 
procedure TForm334.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm334);
end.
