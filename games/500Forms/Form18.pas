unit Form18;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm18 = class(TW3Form)
  private
    {$I 'Form18:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm18 }

procedure TForm18.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm18.InitializeObject;
begin
  inherited;
  {$I 'Form18:impl'}
end;
 
procedure TForm18.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm18);
end.
