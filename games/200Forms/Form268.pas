unit Form268;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm268 = class(TW3Form)
  private
    {$I 'Form268:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm268 }

procedure TForm268.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm268.InitializeObject;
begin
  inherited;
  {$I 'Form268:impl'}
end;
 
procedure TForm268.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm268);
end.
