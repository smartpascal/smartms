unit Form212;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm212 = class(TW3Form)
  private
    {$I 'Form212:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm212 }

procedure TForm212.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm212.InitializeObject;
begin
  inherited;
  {$I 'Form212:impl'}
end;
 
procedure TForm212.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm212);
end.
