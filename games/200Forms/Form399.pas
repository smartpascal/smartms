unit Form399;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm399 = class(TW3Form)
  private
    {$I 'Form399:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm399 }

procedure TForm399.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm399.InitializeObject;
begin
  inherited;
  {$I 'Form399:impl'}
end;
 
procedure TForm399.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm399);
end.
