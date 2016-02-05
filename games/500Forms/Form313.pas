unit Form313;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm313 = class(TW3Form)
  private
    {$I 'Form313:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm313 }

procedure TForm313.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm313.InitializeObject;
begin
  inherited;
  {$I 'Form313:impl'}
end;
 
procedure TForm313.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm313);
end.
