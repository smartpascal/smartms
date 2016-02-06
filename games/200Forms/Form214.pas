unit Form214;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm214 = class(TW3Form)
  private
    {$I 'Form214:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm214 }

procedure TForm214.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm214.InitializeObject;
begin
  inherited;
  {$I 'Form214:impl'}
end;
 
procedure TForm214.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm214);
end.
