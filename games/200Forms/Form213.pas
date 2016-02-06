unit Form213;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm213 = class(TW3Form)
  private
    {$I 'Form213:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm213 }

procedure TForm213.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm213.InitializeObject;
begin
  inherited;
  {$I 'Form213:impl'}
end;
 
procedure TForm213.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm213);
end.
