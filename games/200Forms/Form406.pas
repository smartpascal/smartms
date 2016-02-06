unit Form406;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm406 = class(TW3Form)
  private
    {$I 'Form406:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm406 }

procedure TForm406.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm406.InitializeObject;
begin
  inherited;
  {$I 'Form406:impl'}
end;
 
procedure TForm406.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm406);
end.
