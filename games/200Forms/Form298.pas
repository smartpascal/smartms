unit Form298;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm298 = class(TW3Form)
  private
    {$I 'Form298:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm298 }

procedure TForm298.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm298.InitializeObject;
begin
  inherited;
  {$I 'Form298:impl'}
end;
 
procedure TForm298.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm298);
end.
