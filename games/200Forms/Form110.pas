unit Form110;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm110 = class(TW3Form)
  private
    {$I 'Form110:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm110 }

procedure TForm110.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm110.InitializeObject;
begin
  inherited;
  {$I 'Form110:impl'}
end;
 
procedure TForm110.Resize;
begin
  inherited;
end;

procedure TForm110.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm110);
end.
