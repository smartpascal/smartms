unit Form209;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm209 = class(TW3Form)
  private
    {$I 'Form209:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm209 }

procedure TForm209.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm209.InitializeObject;
begin
  inherited;
  {$I 'Form209:impl'}
end;
 
procedure TForm209.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm209);
end.
