unit Form156;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm156 = class(TW3Form)
  private
    {$I 'Form156:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm156 }

procedure TForm156.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm156.InitializeObject;
begin
  inherited;
  {$I 'Form156:impl'}
end;
 
procedure TForm156.Resize;
begin
  inherited;
end;

procedure TForm156.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm156);
end.
