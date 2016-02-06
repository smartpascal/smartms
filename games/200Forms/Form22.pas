unit Form22;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm22 = class(TW3Form)
  private
    {$I 'Form22:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm22 }

procedure TForm22.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm22.InitializeObject;
begin
  inherited;
  {$I 'Form22:impl'}
end;
 
procedure TForm22.Resize;
begin
  inherited;
end;

procedure TForm22.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm22);
end.
