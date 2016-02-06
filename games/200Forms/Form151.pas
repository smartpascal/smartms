unit Form151;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm151 = class(TW3Form)
  private
    {$I 'Form151:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm151 }

procedure TForm151.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm151.InitializeObject;
begin
  inherited;
  {$I 'Form151:impl'}
end;
 
procedure TForm151.Resize;
begin
  inherited;
end;

procedure TForm151.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm151);
end.
