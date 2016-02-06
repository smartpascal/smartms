unit Form32;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm32 = class(TW3Form)
  private
    {$I 'Form32:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm32 }

procedure TForm32.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm32.InitializeObject;
begin
  inherited;
  {$I 'Form32:impl'}
end;
 
procedure TForm32.Resize;
begin
  inherited;
end;

procedure TForm32.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm32);
end.
