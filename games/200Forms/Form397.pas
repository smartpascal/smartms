unit Form397;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm397 = class(TW3Form)
  private
    {$I 'Form397:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm397 }

procedure TForm397.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm397.InitializeObject;
begin
  inherited;
  {$I 'Form397:impl'}
end;
 
procedure TForm397.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm397);
end.
