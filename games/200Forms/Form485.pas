unit Form485;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm485 = class(TW3Form)
  private
    {$I 'Form485:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm485 }

procedure TForm485.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm485.InitializeObject;
begin
  inherited;
  {$I 'Form485:impl'}
end;
 
procedure TForm485.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm485);
end.
