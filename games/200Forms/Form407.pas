unit Form407;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm407 = class(TW3Form)
  private
    {$I 'Form407:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm407 }

procedure TForm407.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm407.InitializeObject;
begin
  inherited;
  {$I 'Form407:impl'}
end;
 
procedure TForm407.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm407);
end.
