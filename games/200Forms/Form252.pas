unit Form252;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm252 = class(TW3Form)
  private
    {$I 'Form252:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm252 }

procedure TForm252.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm252.InitializeObject;
begin
  inherited;
  {$I 'Form252:impl'}
end;
 
procedure TForm252.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm252);
end.
