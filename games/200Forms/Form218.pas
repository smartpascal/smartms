unit Form218;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm218 = class(TW3Form)
  private
    {$I 'Form218:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm218 }

procedure TForm218.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm218.InitializeObject;
begin
  inherited;
  {$I 'Form218:impl'}
end;
 
procedure TForm218.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm218);
end.
