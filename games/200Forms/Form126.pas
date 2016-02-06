unit Form126;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm126 = class(TW3Form)
  private
    {$I 'Form126:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm126 }

procedure TForm126.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm126.InitializeObject;
begin
  inherited;
  {$I 'Form126:impl'}
end;
 
procedure TForm126.Resize;
begin
  inherited;
end;

procedure TForm126.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm126);
end.
