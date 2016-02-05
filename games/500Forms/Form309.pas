unit Form309;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm309 = class(TW3Form)
  private
    {$I 'Form309:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm309 }

procedure TForm309.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm309.InitializeObject;
begin
  inherited;
  {$I 'Form309:impl'}
end;
 
procedure TForm309.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm309);
end.
