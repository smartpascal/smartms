unit Form206;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm206 = class(TW3Form)
  private
    {$I 'Form206:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm206 }

procedure TForm206.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm206.InitializeObject;
begin
  inherited;
  {$I 'Form206:impl'}
end;
 
procedure TForm206.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm206);
end.
