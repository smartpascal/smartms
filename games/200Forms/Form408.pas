unit Form408;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm408 = class(TW3Form)
  private
    {$I 'Form408:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm408 }

procedure TForm408.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm408.InitializeObject;
begin
  inherited;
  {$I 'Form408:impl'}
end;
 
procedure TForm408.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm408);
end.
