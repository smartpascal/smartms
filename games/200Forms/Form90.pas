unit Form90;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm90 = class(TW3Form)
  private
    {$I 'Form90:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm90 }

procedure TForm90.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm90.InitializeObject;
begin
  inherited;
  {$I 'Form90:impl'}
end;
 
procedure TForm90.Resize;
begin
  inherited;
end;

procedure TForm90.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm90);
end.
