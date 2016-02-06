unit Form370;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm370 = class(TW3Form)
  private
    {$I 'Form370:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm370 }

procedure TForm370.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm370.InitializeObject;
begin
  inherited;
  {$I 'Form370:impl'}
end;
 
procedure TForm370.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm370);
end.
