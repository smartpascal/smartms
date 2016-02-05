unit Form52;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm52 = class(TW3Form)
  private
    {$I 'Form52:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm52 }

procedure TForm52.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm52.InitializeObject;
begin
  inherited;
  {$I 'Form52:impl'}
end;
 
procedure TForm52.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm52);
end.
