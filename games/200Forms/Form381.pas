unit Form381;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm381 = class(TW3Form)
  private
    {$I 'Form381:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm381 }

procedure TForm381.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm381.InitializeObject;
begin
  inherited;
  {$I 'Form381:impl'}
end;
 
procedure TForm381.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm381);
end.
