unit Form344;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm344 = class(TW3Form)
  private
    {$I 'Form344:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm344 }

procedure TForm344.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm344.InitializeObject;
begin
  inherited;
  {$I 'Form344:impl'}
end;
 
procedure TForm344.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm344);
end.
