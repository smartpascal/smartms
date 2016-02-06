unit Form343;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm343 = class(TW3Form)
  private
    {$I 'Form343:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm343 }

procedure TForm343.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm343.InitializeObject;
begin
  inherited;
  {$I 'Form343:impl'}
end;
 
procedure TForm343.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm343);
end.
