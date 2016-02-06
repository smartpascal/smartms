unit Form178;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm178 = class(TW3Form)
  private
    {$I 'Form178:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm178 }

procedure TForm178.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm178.InitializeObject;
begin
  inherited;
  {$I 'Form178:impl'}
end;
 
procedure TForm178.Resize;
begin
  inherited;
end;

procedure TForm178.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm178);
end.
