unit Form367;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm367 = class(TW3Form)
  private
    {$I 'Form367:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm367 }

procedure TForm367.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm367.InitializeObject;
begin
  inherited;
  {$I 'Form367:impl'}
end;
 
procedure TForm367.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm367);
end.
