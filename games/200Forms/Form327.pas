unit Form327;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm327 = class(TW3Form)
  private
    {$I 'Form327:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm327 }

procedure TForm327.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm327.InitializeObject;
begin
  inherited;
  {$I 'Form327:impl'}
end;
 
procedure TForm327.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm327);
end.
