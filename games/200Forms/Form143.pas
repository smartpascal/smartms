unit Form143;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm143 = class(TW3Form)
  private
    {$I 'Form143:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm143 }

procedure TForm143.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm143.InitializeObject;
begin
  inherited;
  {$I 'Form143:impl'}
end;
 
procedure TForm143.Resize;
begin
  inherited;
end;

procedure TForm143.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm143);
end.
