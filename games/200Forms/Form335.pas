unit Form335;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm335 = class(TW3Form)
  private
    {$I 'Form335:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm335 }

procedure TForm335.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm335.InitializeObject;
begin
  inherited;
  {$I 'Form335:impl'}
end;
 
procedure TForm335.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm335);
end.
