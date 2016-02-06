unit Form482;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm482 = class(TW3Form)
  private
    {$I 'Form482:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm482 }

procedure TForm482.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm482.InitializeObject;
begin
  inherited;
  {$I 'Form482:impl'}
end;
 
procedure TForm482.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm482);
end.
