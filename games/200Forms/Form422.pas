unit Form422;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm422 = class(TW3Form)
  private
    {$I 'Form422:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm422 }

procedure TForm422.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm422.InitializeObject;
begin
  inherited;
  {$I 'Form422:impl'}
end;
 
procedure TForm422.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm422);
end.
