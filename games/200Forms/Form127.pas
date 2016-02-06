unit Form127;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm127 = class(TW3Form)
  private
    {$I 'Form127:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm127 }

procedure TForm127.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm127.InitializeObject;
begin
  inherited;
  {$I 'Form127:impl'}
end;
 
procedure TForm127.Resize;
begin
  inherited;
end;

procedure TForm127.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm127);
end.
