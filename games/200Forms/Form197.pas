unit Form197;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm197 = class(TW3Form)
  private
    {$I 'Form197:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm197 }

procedure TForm197.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm197.InitializeObject;
begin
  inherited;
  {$I 'Form197:impl'}
end;
 
procedure TForm197.Resize;
begin
  inherited;
end;

procedure TForm197.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm197);
end.
