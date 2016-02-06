unit Form163;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm163 = class(TW3Form)
  private
    {$I 'Form163:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm163 }

procedure TForm163.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm163.InitializeObject;
begin
  inherited;
  {$I 'Form163:impl'}
end;
 
procedure TForm163.Resize;
begin
  inherited;
end;

procedure TForm163.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm163);
end.
