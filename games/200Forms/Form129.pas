unit Form129;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm129 = class(TW3Form)
  private
    {$I 'Form129:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm129 }

procedure TForm129.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm129.InitializeObject;
begin
  inherited;
  {$I 'Form129:impl'}
end;
 
procedure TForm129.Resize;
begin
  inherited;
end;

procedure TForm129.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm129);
end.
