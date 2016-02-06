unit Form404;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm404 = class(TW3Form)
  private
    {$I 'Form404:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm404 }

procedure TForm404.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm404.InitializeObject;
begin
  inherited;
  {$I 'Form404:impl'}
end;
 
procedure TForm404.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm404);
end.
