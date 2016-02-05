unit Form328;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm328 = class(TW3Form)
  private
    {$I 'Form328:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm328 }

procedure TForm328.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm328.InitializeObject;
begin
  inherited;
  {$I 'Form328:impl'}
end;
 
procedure TForm328.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm328);
end.
