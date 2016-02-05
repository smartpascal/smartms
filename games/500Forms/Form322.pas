unit Form322;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm322 = class(TW3Form)
  private
    {$I 'Form322:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm322 }

procedure TForm322.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm322.InitializeObject;
begin
  inherited;
  {$I 'Form322:impl'}
end;
 
procedure TForm322.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm322);
end.
