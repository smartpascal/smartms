unit Form258;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm258 = class(TW3Form)
  private
    {$I 'Form258:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm258 }

procedure TForm258.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm258.InitializeObject;
begin
  inherited;
  {$I 'Form258:impl'}
end;
 
procedure TForm258.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm258);
end.
