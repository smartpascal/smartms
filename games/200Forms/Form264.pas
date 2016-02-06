unit Form264;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm264 = class(TW3Form)
  private
    {$I 'Form264:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm264 }

procedure TForm264.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm264.InitializeObject;
begin
  inherited;
  {$I 'Form264:impl'}
end;
 
procedure TForm264.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm264);
end.
