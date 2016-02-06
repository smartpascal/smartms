unit Form302;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm302 = class(TW3Form)
  private
    {$I 'Form302:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm302 }

procedure TForm302.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm302.InitializeObject;
begin
  inherited;
  {$I 'Form302:impl'}
end;
 
procedure TForm302.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm302);
end.
