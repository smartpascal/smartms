unit Form401;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm401 = class(TW3Form)
  private
    {$I 'Form401:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm401 }

procedure TForm401.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm401.InitializeObject;
begin
  inherited;
  {$I 'Form401:impl'}
end;
 
procedure TForm401.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm401);
end.
