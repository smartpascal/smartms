unit Form368;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm368 = class(TW3Form)
  private
    {$I 'Form368:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm368 }

procedure TForm368.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm368.InitializeObject;
begin
  inherited;
  {$I 'Form368:impl'}
end;
 
procedure TForm368.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm368);
end.
