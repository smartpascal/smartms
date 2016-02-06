unit Form109;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm109 = class(TW3Form)
  private
    {$I 'Form109:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm109 }

procedure TForm109.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm109.InitializeObject;
begin
  inherited;
  {$I 'Form109:impl'}
end;
 
procedure TForm109.Resize;
begin
  inherited;
end;

procedure TForm109.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm109);
end.
