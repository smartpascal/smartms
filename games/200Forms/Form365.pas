unit Form365;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm365 = class(TW3Form)
  private
    {$I 'Form365:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm365 }

procedure TForm365.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm365.InitializeObject;
begin
  inherited;
  {$I 'Form365:impl'}
end;
 
procedure TForm365.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm365);
end.
