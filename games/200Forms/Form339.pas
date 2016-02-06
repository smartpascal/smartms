unit Form339;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm339 = class(TW3Form)
  private
    {$I 'Form339:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm339 }

procedure TForm339.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm339.InitializeObject;
begin
  inherited;
  {$I 'Form339:impl'}
end;
 
procedure TForm339.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm339);
end.
