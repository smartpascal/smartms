unit Form263;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm263 = class(TW3Form)
  private
    {$I 'Form263:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm263 }

procedure TForm263.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm263.InitializeObject;
begin
  inherited;
  {$I 'Form263:impl'}
end;
 
procedure TForm263.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm263);
end.
