unit Form400;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm400 = class(TW3Form)
  private
    {$I 'Form400:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm400 }

procedure TForm400.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm400.InitializeObject;
begin
  inherited;
  {$I 'Form400:impl'}
end;
 
procedure TForm400.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm400);
end.
