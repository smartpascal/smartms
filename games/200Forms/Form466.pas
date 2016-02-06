unit Form466;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm466 = class(TW3Form)
  private
    {$I 'Form466:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm466 }

procedure TForm466.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm466.InitializeObject;
begin
  inherited;
  {$I 'Form466:impl'}
end;
 
procedure TForm466.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm466);
end.
