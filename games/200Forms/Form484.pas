unit Form484;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm484 = class(TW3Form)
  private
    {$I 'Form484:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm484 }

procedure TForm484.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm484.InitializeObject;
begin
  inherited;
  {$I 'Form484:impl'}
end;
 
procedure TForm484.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm484);
end.
