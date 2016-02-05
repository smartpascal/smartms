unit Form169;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm169 = class(TW3Form)
  private
    {$I 'Form169:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm169 }

procedure TForm169.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm169.InitializeObject;
begin
  inherited;
  {$I 'Form169:impl'}
end;
 
procedure TForm169.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm169);
end.
