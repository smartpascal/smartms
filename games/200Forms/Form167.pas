unit Form167;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm167 = class(TW3Form)
  private
    {$I 'Form167:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm167 }

procedure TForm167.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm167.InitializeObject;
begin
  inherited;
  {$I 'Form167:impl'}
end;
 
procedure TForm167.Resize;
begin
  inherited;
end;

procedure TForm167.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm167);
end.
