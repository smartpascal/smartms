unit Form275;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm275 = class(TW3Form)
  private
    {$I 'Form275:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm275 }

procedure TForm275.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm275.InitializeObject;
begin
  inherited;
  {$I 'Form275:impl'}
end;
 
procedure TForm275.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm275);
end.
