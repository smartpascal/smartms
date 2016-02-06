unit Form260;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm260 = class(TW3Form)
  private
    {$I 'Form260:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm260 }

procedure TForm260.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm260.InitializeObject;
begin
  inherited;
  {$I 'Form260:impl'}
end;
 
procedure TForm260.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm260);
end.
