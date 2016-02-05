unit Form436;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm436 = class(TW3Form)
  private
    {$I 'Form436:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm436 }

procedure TForm436.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm436.InitializeObject;
begin
  inherited;
  {$I 'Form436:impl'}
end;
 
procedure TForm436.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm436);
end.
