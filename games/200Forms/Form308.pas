unit Form308;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm308 = class(TW3Form)
  private
    {$I 'Form308:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm308 }

procedure TForm308.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm308.InitializeObject;
begin
  inherited;
  {$I 'Form308:impl'}
end;
 
procedure TForm308.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm308);
end.
