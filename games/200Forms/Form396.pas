unit Form396;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm396 = class(TW3Form)
  private
    {$I 'Form396:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm396 }

procedure TForm396.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm396.InitializeObject;
begin
  inherited;
  {$I 'Form396:impl'}
end;
 
procedure TForm396.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm396);
end.
