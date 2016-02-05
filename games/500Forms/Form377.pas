unit Form377;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm377 = class(TW3Form)
  private
    {$I 'Form377:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm377 }

procedure TForm377.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm377.InitializeObject;
begin
  inherited;
  {$I 'Form377:impl'}
end;
 
procedure TForm377.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm377);
end.
