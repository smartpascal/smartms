unit Form294;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm294 = class(TW3Form)
  private
    {$I 'Form294:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm294 }

procedure TForm294.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm294.InitializeObject;
begin
  inherited;
  {$I 'Form294:impl'}
end;
 
procedure TForm294.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm294);
end.
