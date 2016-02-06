unit Form354;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm354 = class(TW3Form)
  private
    {$I 'Form354:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm354 }

procedure TForm354.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm354.InitializeObject;
begin
  inherited;
  {$I 'Form354:impl'}
end;
 
procedure TForm354.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm354);
end.
