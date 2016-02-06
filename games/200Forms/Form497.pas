unit Form497;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm497 = class(TW3Form)
  private
    {$I 'Form497:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm497 }

procedure TForm497.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm497.InitializeObject;
begin
  inherited;
  {$I 'Form497:impl'}
end;
 
procedure TForm497.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm497);
end.
