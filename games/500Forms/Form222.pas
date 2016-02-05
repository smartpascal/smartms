unit Form222;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm222 = class(TW3Form)
  private
    {$I 'Form222:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm222 }

procedure TForm222.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm222.InitializeObject;
begin
  inherited;
  {$I 'Form222:impl'}
end;
 
procedure TForm222.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm222);
end.
