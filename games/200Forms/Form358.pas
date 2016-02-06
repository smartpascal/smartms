unit Form358;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm358 = class(TW3Form)
  private
    {$I 'Form358:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm358 }

procedure TForm358.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm358.InitializeObject;
begin
  inherited;
  {$I 'Form358:impl'}
end;
 
procedure TForm358.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm358);
end.
