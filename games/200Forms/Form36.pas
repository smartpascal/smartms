unit Form36;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm36 = class(TW3Form)
  private
    {$I 'Form36:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm36 }

procedure TForm36.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm36.InitializeObject;
begin
  inherited;
  {$I 'Form36:impl'}
end;
 
procedure TForm36.Resize;
begin
  inherited;
end;

procedure TForm36.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm36);
end.
