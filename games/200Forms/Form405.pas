unit Form405;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm405 = class(TW3Form)
  private
    {$I 'Form405:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm405 }

procedure TForm405.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm405.InitializeObject;
begin
  inherited;
  {$I 'Form405:impl'}
end;
 
procedure TForm405.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm405);
end.
