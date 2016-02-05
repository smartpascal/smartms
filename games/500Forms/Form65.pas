unit Form65;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm65 = class(TW3Form)
  private
    {$I 'Form65:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm65 }

procedure TForm65.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm65.InitializeObject;
begin
  inherited;
  {$I 'Form65:impl'}
end;
 
procedure TForm65.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm65);
end.
