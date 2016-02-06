unit Form461;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm461 = class(TW3Form)
  private
    {$I 'Form461:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm461 }

procedure TForm461.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm461.InitializeObject;
begin
  inherited;
  {$I 'Form461:impl'}
end;
 
procedure TForm461.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm461);
end.
