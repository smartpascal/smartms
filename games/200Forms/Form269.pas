unit Form269;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm269 = class(TW3Form)
  private
    {$I 'Form269:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm269 }

procedure TForm269.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm269.InitializeObject;
begin
  inherited;
  {$I 'Form269:impl'}
end;
 
procedure TForm269.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm269);
end.
