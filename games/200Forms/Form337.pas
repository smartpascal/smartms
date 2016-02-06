unit Form337;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm337 = class(TW3Form)
  private
    {$I 'Form337:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm337 }

procedure TForm337.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm337.InitializeObject;
begin
  inherited;
  {$I 'Form337:impl'}
end;
 
procedure TForm337.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm337);
end.
