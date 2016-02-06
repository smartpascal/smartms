unit Form414;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm414 = class(TW3Form)
  private
    {$I 'Form414:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm414 }

procedure TForm414.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm414.InitializeObject;
begin
  inherited;
  {$I 'Form414:impl'}
end;
 
procedure TForm414.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm414);
end.
