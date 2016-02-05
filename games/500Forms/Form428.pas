unit Form428;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm428 = class(TW3Form)
  private
    {$I 'Form428:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm428 }

procedure TForm428.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm428.InitializeObject;
begin
  inherited;
  {$I 'Form428:impl'}
end;
 
procedure TForm428.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm428);
end.
