unit Form20;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm20 = class(TW3Form)
  private
    {$I 'Form20:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm20 }

procedure TForm20.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm20.InitializeObject;
begin
  inherited;
  {$I 'Form20:impl'}
end;
 
procedure TForm20.Resize;
begin
  inherited;
end;

procedure TForm20.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm20);
end.
