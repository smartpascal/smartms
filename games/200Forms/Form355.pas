unit Form355;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm355 = class(TW3Form)
  private
    {$I 'Form355:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm355 }

procedure TForm355.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm355.InitializeObject;
begin
  inherited;
  {$I 'Form355:impl'}
end;
 
procedure TForm355.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm355);
end.
