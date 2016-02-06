unit Form324;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm324 = class(TW3Form)
  private
    {$I 'Form324:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm324 }

procedure TForm324.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm324.InitializeObject;
begin
  inherited;
  {$I 'Form324:impl'}
end;
 
procedure TForm324.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm324);
end.
