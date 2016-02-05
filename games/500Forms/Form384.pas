unit Form384;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm384 = class(TW3Form)
  private
    {$I 'Form384:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm384 }

procedure TForm384.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm384.InitializeObject;
begin
  inherited;
  {$I 'Form384:impl'}
end;
 
procedure TForm384.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm384);
end.
