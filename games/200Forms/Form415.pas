unit Form415;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm415 = class(TW3Form)
  private
    {$I 'Form415:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm415 }

procedure TForm415.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm415.InitializeObject;
begin
  inherited;
  {$I 'Form415:impl'}
end;
 
procedure TForm415.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm415);
end.
