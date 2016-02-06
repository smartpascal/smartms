unit Form88;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm88 = class(TW3Form)
  private
    {$I 'Form88:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm88 }

procedure TForm88.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm88.InitializeObject;
begin
  inherited;
  {$I 'Form88:impl'}
end;
 
procedure TForm88.Resize;
begin
  inherited;
end;

procedure TForm88.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm88);
end.
