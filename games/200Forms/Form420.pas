unit Form420;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm420 = class(TW3Form)
  private
    {$I 'Form420:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm420 }

procedure TForm420.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm420.InitializeObject;
begin
  inherited;
  {$I 'Form420:impl'}
end;
 
procedure TForm420.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm420);
end.
