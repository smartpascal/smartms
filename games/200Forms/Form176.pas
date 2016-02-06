unit Form176;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm176 = class(TW3Form)
  private
    {$I 'Form176:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm176 }

procedure TForm176.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm176.InitializeObject;
begin
  inherited;
  {$I 'Form176:impl'}
end;
 
procedure TForm176.Resize;
begin
  inherited;
end;

procedure TForm176.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm176);
end.
