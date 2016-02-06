unit Form336;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm336 = class(TW3Form)
  private
    {$I 'Form336:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm336 }

procedure TForm336.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm336.InitializeObject;
begin
  inherited;
  {$I 'Form336:impl'}
end;
 
procedure TForm336.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm336);
end.
