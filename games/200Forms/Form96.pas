unit Form96;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm96 = class(TW3Form)
  private
    {$I 'Form96:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm96 }

procedure TForm96.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm96.InitializeObject;
begin
  inherited;
  {$I 'Form96:impl'}
end;
 
procedure TForm96.Resize;
begin
  inherited;
end;

procedure TForm96.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm96);
end.
