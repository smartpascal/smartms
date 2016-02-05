unit Form17;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm17 = class(TW3Form)
  private
    {$I 'Form17:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm17 }

procedure TForm17.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm17.InitializeObject;
begin
  inherited;
  {$I 'Form17:impl'}
end;
 
procedure TForm17.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm17);
end.
