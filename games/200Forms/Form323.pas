unit Form323;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm323 = class(TW3Form)
  private
    {$I 'Form323:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm323 }

procedure TForm323.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm323.InitializeObject;
begin
  inherited;
  {$I 'Form323:impl'}
end;
 
procedure TForm323.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm323);
end.
