unit Form187;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm187 = class(TW3Form)
  private
    {$I 'Form187:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm187 }

procedure TForm187.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm187.InitializeObject;
begin
  inherited;
  {$I 'Form187:impl'}
end;
 
procedure TForm187.Resize;
begin
  inherited;
end;

procedure TForm187.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm187);
end.
