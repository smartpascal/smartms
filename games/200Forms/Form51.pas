unit Form51;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm51 = class(TW3Form)
  private
    {$I 'Form51:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm51 }

procedure TForm51.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm51.InitializeObject;
begin
  inherited;
  {$I 'Form51:impl'}
end;
 
procedure TForm51.Resize;
begin
  inherited;
end;

procedure TForm51.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm51);
end.
