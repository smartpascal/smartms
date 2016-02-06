unit Form445;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm445 = class(TW3Form)
  private
    {$I 'Form445:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm445 }

procedure TForm445.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm445.InitializeObject;
begin
  inherited;
  {$I 'Form445:impl'}
end;
 
procedure TForm445.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm445);
end.
