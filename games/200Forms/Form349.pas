unit Form349;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm349 = class(TW3Form)
  private
    {$I 'Form349:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm349 }

procedure TForm349.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm349.InitializeObject;
begin
  inherited;
  {$I 'Form349:impl'}
end;
 
procedure TForm349.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm349);
end.
