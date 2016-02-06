unit Form307;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm307 = class(TW3Form)
  private
    {$I 'Form307:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm307 }

procedure TForm307.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm307.InitializeObject;
begin
  inherited;
  {$I 'Form307:impl'}
end;
 
procedure TForm307.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm307);
end.
