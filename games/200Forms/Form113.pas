unit Form113;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm113 = class(TW3Form)
  private
    {$I 'Form113:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm113 }

procedure TForm113.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm113.InitializeObject;
begin
  inherited;
  {$I 'Form113:impl'}
end;
 
procedure TForm113.Resize;
begin
  inherited;
end;

procedure TForm113.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm113);
end.
