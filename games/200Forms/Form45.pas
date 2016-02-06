unit Form45;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm45 = class(TW3Form)
  private
    {$I 'Form45:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm45 }

procedure TForm45.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm45.InitializeObject;
begin
  inherited;
  {$I 'Form45:impl'}
end;
 
procedure TForm45.Resize;
begin
  inherited;
end;

procedure TForm45.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm45);
end.
