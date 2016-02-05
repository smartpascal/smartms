unit Form25;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm25 = class(TW3Form)
  private
    {$I 'Form25:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm25 }

procedure TForm25.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm25.InitializeObject;
begin
  inherited;
  {$I 'Form25:impl'}
end;
 
procedure TForm25.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm25);
end.
