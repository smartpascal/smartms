unit Form216;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm216 = class(TW3Form)
  private
    {$I 'Form216:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm216 }

procedure TForm216.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm216.InitializeObject;
begin
  inherited;
  {$I 'Form216:impl'}
end;
 
procedure TForm216.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm216);
end.
