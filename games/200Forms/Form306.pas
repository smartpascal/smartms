unit Form306;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm306 = class(TW3Form)
  private
    {$I 'Form306:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm306 }

procedure TForm306.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm306.InitializeObject;
begin
  inherited;
  {$I 'Form306:impl'}
end;
 
procedure TForm306.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm306);
end.
