unit Form440;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm440 = class(TW3Form)
  private
    {$I 'Form440:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm440 }

procedure TForm440.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm440.InitializeObject;
begin
  inherited;
  {$I 'Form440:impl'}
end;
 
procedure TForm440.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm440);
end.
