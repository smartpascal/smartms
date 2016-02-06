unit Form33;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm33 = class(TW3Form)
  private
    {$I 'Form33:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm33 }

procedure TForm33.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm33.InitializeObject;
begin
  inherited;
  {$I 'Form33:impl'}
end;
 
procedure TForm33.Resize;
begin
  inherited;
end;

procedure TForm33.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm33);
end.
