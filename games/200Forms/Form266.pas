unit Form266;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm266 = class(TW3Form)
  private
    {$I 'Form266:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm266 }

procedure TForm266.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm266.InitializeObject;
begin
  inherited;
  {$I 'Form266:impl'}
end;
 
procedure TForm266.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm266);
end.
