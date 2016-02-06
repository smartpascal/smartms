unit Form491;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm491 = class(TW3Form)
  private
    {$I 'Form491:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm491 }

procedure TForm491.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm491.InitializeObject;
begin
  inherited;
  {$I 'Form491:impl'}
end;
 
procedure TForm491.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm491);
end.
