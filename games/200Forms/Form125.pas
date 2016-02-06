unit Form125;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm125 = class(TW3Form)
  private
    {$I 'Form125:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm125 }

procedure TForm125.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm125.InitializeObject;
begin
  inherited;
  {$I 'Form125:impl'}
end;
 
procedure TForm125.Resize;
begin
  inherited;
end;

procedure TForm125.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm125);
end.
