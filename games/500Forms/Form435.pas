unit Form435;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm435 = class(TW3Form)
  private
    {$I 'Form435:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm435 }

procedure TForm435.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm435.InitializeObject;
begin
  inherited;
  {$I 'Form435:impl'}
end;
 
procedure TForm435.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm435);
end.
