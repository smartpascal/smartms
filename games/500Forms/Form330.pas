unit Form330;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm330 = class(TW3Form)
  private
    {$I 'Form330:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm330 }

procedure TForm330.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm330.InitializeObject;
begin
  inherited;
  {$I 'Form330:impl'}
end;
 
procedure TForm330.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm330);
end.
