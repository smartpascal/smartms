unit Form382;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm382 = class(TW3Form)
  private
    {$I 'Form382:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm382 }

procedure TForm382.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm382.InitializeObject;
begin
  inherited;
  {$I 'Form382:impl'}
end;
 
procedure TForm382.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm382);
end.
