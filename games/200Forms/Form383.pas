unit Form383;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm383 = class(TW3Form)
  private
    {$I 'Form383:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm383 }

procedure TForm383.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm383.InitializeObject;
begin
  inherited;
  {$I 'Form383:impl'}
end;
 
procedure TForm383.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm383);
end.
