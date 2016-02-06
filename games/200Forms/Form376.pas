unit Form376;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm376 = class(TW3Form)
  private
    {$I 'Form376:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm376 }

procedure TForm376.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm376.InitializeObject;
begin
  inherited;
  {$I 'Form376:impl'}
end;
 
procedure TForm376.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm376);
end.
