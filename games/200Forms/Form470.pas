unit Form470;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm470 = class(TW3Form)
  private
    {$I 'Form470:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm470 }

procedure TForm470.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm470.InitializeObject;
begin
  inherited;
  {$I 'Form470:impl'}
end;
 
procedure TForm470.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm470);
end.
