unit Form189;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm189 = class(TW3Form)
  private
    {$I 'Form189:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm189 }

procedure TForm189.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm189.InitializeObject;
begin
  inherited;
  {$I 'Form189:impl'}
end;
 
procedure TForm189.Resize;
begin
  inherited;
end;

procedure TForm189.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm189);
end.
