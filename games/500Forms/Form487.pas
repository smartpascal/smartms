unit Form487;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm487 = class(TW3Form)
  private
    {$I 'Form487:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm487 }

procedure TForm487.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm487.InitializeObject;
begin
  inherited;
  {$I 'Form487:impl'}
end;
 
procedure TForm487.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm487);
end.
