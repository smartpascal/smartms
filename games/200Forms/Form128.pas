unit Form128;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm128 = class(TW3Form)
  private
    {$I 'Form128:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm128 }

procedure TForm128.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm128.InitializeObject;
begin
  inherited;
  {$I 'Form128:impl'}
end;
 
procedure TForm128.Resize;
begin
  inherited;
end;

procedure TForm128.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm128);
end.
