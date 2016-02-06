unit Form423;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm423 = class(TW3Form)
  private
    {$I 'Form423:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm423 }

procedure TForm423.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm423.InitializeObject;
begin
  inherited;
  {$I 'Form423:impl'}
end;
 
procedure TForm423.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm423);
end.
