unit Form42;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm42 = class(TW3Form)
  private
    {$I 'Form42:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm42 }

procedure TForm42.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm42.InitializeObject;
begin
  inherited;
  {$I 'Form42:impl'}
end;
 
procedure TForm42.Resize;
begin
  inherited;
end;

procedure TForm42.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm42);
end.
