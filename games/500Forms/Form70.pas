unit Form70;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm70 = class(TW3Form)
  private
    {$I 'Form70:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm70 }

procedure TForm70.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm70.InitializeObject;
begin
  inherited;
  {$I 'Form70:impl'}
end;
 
procedure TForm70.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm70);
end.
