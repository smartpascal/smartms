unit Form221;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm221 = class(TW3Form)
  private
    {$I 'Form221:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm221 }

procedure TForm221.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm221.InitializeObject;
begin
  inherited;
  {$I 'Form221:impl'}
end;
 
procedure TForm221.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm221);
end.
