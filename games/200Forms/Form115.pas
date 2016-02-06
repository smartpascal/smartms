unit Form115;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm115 = class(TW3Form)
  private
    {$I 'Form115:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm115 }

procedure TForm115.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm115.InitializeObject;
begin
  inherited;
  {$I 'Form115:impl'}
end;
 
procedure TForm115.Resize;
begin
  inherited;
end;

procedure TForm115.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm115);
end.
