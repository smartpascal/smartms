unit Form463;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm463 = class(TW3Form)
  private
    {$I 'Form463:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm463 }

procedure TForm463.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm463.InitializeObject;
begin
  inherited;
  {$I 'Form463:impl'}
end;
 
procedure TForm463.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm463);
end.
