unit Form390;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm390 = class(TW3Form)
  private
    {$I 'Form390:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm390 }

procedure TForm390.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm390.InitializeObject;
begin
  inherited;
  {$I 'Form390:impl'}
end;
 
procedure TForm390.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm390);
end.
