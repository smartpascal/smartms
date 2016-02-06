unit Form475;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm475 = class(TW3Form)
  private
    {$I 'Form475:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm475 }

procedure TForm475.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm475.InitializeObject;
begin
  inherited;
  {$I 'Form475:impl'}
end;
 
procedure TForm475.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm475);
end.
