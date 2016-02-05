unit Form444;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm444 = class(TW3Form)
  private
    {$I 'Form444:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm444 }

procedure TForm444.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm444.InitializeObject;
begin
  inherited;
  {$I 'Form444:impl'}
end;
 
procedure TForm444.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm444);
end.
