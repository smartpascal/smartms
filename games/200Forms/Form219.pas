unit Form219;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm219 = class(TW3Form)
  private
    {$I 'Form219:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm219 }

procedure TForm219.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm219.InitializeObject;
begin
  inherited;
  {$I 'Form219:impl'}
end;
 
procedure TForm219.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm219);
end.
