unit Form296;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm296 = class(TW3Form)
  private
    {$I 'Form296:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm296 }

procedure TForm296.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm296.InitializeObject;
begin
  inherited;
  {$I 'Form296:impl'}
end;
 
procedure TForm296.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm296);
end.
