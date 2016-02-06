unit Form369;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm369 = class(TW3Form)
  private
    {$I 'Form369:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm369 }

procedure TForm369.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm369.InitializeObject;
begin
  inherited;
  {$I 'Form369:impl'}
end;
 
procedure TForm369.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm369);
end.
