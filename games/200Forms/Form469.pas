unit Form469;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm469 = class(TW3Form)
  private
    {$I 'Form469:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm469 }

procedure TForm469.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm469.InitializeObject;
begin
  inherited;
  {$I 'Form469:impl'}
end;
 
procedure TForm469.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm469);
end.
