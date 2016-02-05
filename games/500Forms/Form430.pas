unit Form430;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm430 = class(TW3Form)
  private
    {$I 'Form430:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm430 }

procedure TForm430.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm430.InitializeObject;
begin
  inherited;
  {$I 'Form430:impl'}
end;
 
procedure TForm430.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm430);
end.
