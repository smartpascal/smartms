unit Form437;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm437 = class(TW3Form)
  private
    {$I 'Form437:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm437 }

procedure TForm437.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm437.InitializeObject;
begin
  inherited;
  {$I 'Form437:impl'}
end;
 
procedure TForm437.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm437);
end.
