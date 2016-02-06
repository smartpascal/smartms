unit Form419;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm419 = class(TW3Form)
  private
    {$I 'Form419:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm419 }

procedure TForm419.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm419.InitializeObject;
begin
  inherited;
  {$I 'Form419:impl'}
end;
 
procedure TForm419.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm419);
end.
