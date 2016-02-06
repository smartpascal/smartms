unit Form190;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm190 = class(TW3Form)
  private
    {$I 'Form190:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm190 }

procedure TForm190.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm190.InitializeObject;
begin
  inherited;
  {$I 'Form190:impl'}
end;
 
procedure TForm190.Resize;
begin
  inherited;
end;

procedure TForm190.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm190);
end.
