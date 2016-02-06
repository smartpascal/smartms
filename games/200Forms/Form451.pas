unit Form451;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm451 = class(TW3Form)
  private
    {$I 'Form451:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm451 }

procedure TForm451.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm451.InitializeObject;
begin
  inherited;
  {$I 'Form451:impl'}
end;
 
procedure TForm451.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm451);
end.
