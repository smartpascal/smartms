unit Form257;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm257 = class(TW3Form)
  private
    {$I 'Form257:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm257 }

procedure TForm257.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm257.InitializeObject;
begin
  inherited;
  {$I 'Form257:impl'}
end;
 
procedure TForm257.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm257);
end.
