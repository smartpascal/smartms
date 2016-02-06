unit Form356;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm356 = class(TW3Form)
  private
    {$I 'Form356:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm356 }

procedure TForm356.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm356.InitializeObject;
begin
  inherited;
  {$I 'Form356:impl'}
end;
 
procedure TForm356.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm356);
end.
