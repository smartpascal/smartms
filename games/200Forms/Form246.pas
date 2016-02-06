unit Form246;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm246 = class(TW3Form)
  private
    {$I 'Form246:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm246 }

procedure TForm246.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm246.InitializeObject;
begin
  inherited;
  {$I 'Form246:impl'}
end;
 
procedure TForm246.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm246);
end.
