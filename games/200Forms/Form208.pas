unit Form208;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm208 = class(TW3Form)
  private
    {$I 'Form208:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm208 }

procedure TForm208.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm208.InitializeObject;
begin
  inherited;
  {$I 'Form208:impl'}
end;
 
procedure TForm208.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm208);
end.
