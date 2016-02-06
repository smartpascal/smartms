unit Form314;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm314 = class(TW3Form)
  private
    {$I 'Form314:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm314 }

procedure TForm314.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm314.InitializeObject;
begin
  inherited;
  {$I 'Form314:impl'}
end;
 
procedure TForm314.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm314);
end.
