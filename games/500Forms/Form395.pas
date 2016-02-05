unit Form395;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm395 = class(TW3Form)
  private
    {$I 'Form395:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm395 }

procedure TForm395.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm395.InitializeObject;
begin
  inherited;
  {$I 'Form395:impl'}
end;
 
procedure TForm395.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm395);
end.
