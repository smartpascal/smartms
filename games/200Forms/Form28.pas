unit Form28;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm28 = class(TW3Form)
  private
    {$I 'Form28:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm28 }

procedure TForm28.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm28.InitializeObject;
begin
  inherited;
  {$I 'Form28:impl'}
end;
 
procedure TForm28.Resize;
begin
  inherited;
end;

procedure TForm28.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm28);
end.
