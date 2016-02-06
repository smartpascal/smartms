unit Form385;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm385 = class(TW3Form)
  private
    {$I 'Form385:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm385 }

procedure TForm385.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm385.InitializeObject;
begin
  inherited;
  {$I 'Form385:impl'}
end;
 
procedure TForm385.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm385);
end.
