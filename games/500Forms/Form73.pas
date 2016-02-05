unit Form73;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm73 = class(TW3Form)
  private
    {$I 'Form73:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm73 }

procedure TForm73.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm73.InitializeObject;
begin
  inherited;
  {$I 'Form73:impl'}
end;
 
procedure TForm73.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm73);
end.
