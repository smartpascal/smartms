unit Form346;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm346 = class(TW3Form)
  private
    {$I 'Form346:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm346 }

procedure TForm346.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm346.InitializeObject;
begin
  inherited;
  {$I 'Form346:impl'}
end;
 
procedure TForm346.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm346);
end.
