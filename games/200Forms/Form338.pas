unit Form338;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm338 = class(TW3Form)
  private
    {$I 'Form338:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm338 }

procedure TForm338.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm338.InitializeObject;
begin
  inherited;
  {$I 'Form338:impl'}
end;
 
procedure TForm338.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm338);
end.
