unit Form359;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm359 = class(TW3Form)
  private
    {$I 'Form359:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm359 }

procedure TForm359.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm359.InitializeObject;
begin
  inherited;
  {$I 'Form359:impl'}
end;
 
procedure TForm359.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm359);
end.
