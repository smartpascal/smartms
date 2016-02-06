unit Form347;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm347 = class(TW3Form)
  private
    {$I 'Form347:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm347 }

procedure TForm347.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm347.InitializeObject;
begin
  inherited;
  {$I 'Form347:impl'}
end;
 
procedure TForm347.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm347);
end.
