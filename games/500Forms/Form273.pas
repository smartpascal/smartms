unit Form273;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm273 = class(TW3Form)
  private
    {$I 'Form273:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm273 }

procedure TForm273.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm273.InitializeObject;
begin
  inherited;
  {$I 'Form273:impl'}
end;
 
procedure TForm273.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm273);
end.
