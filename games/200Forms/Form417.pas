unit Form417;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm417 = class(TW3Form)
  private
    {$I 'Form417:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm417 }

procedure TForm417.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm417.InitializeObject;
begin
  inherited;
  {$I 'Form417:impl'}
end;
 
procedure TForm417.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm417);
end.
