unit Form468;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm468 = class(TW3Form)
  private
    {$I 'Form468:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm468 }

procedure TForm468.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm468.InitializeObject;
begin
  inherited;
  {$I 'Form468:impl'}
end;
 
procedure TForm468.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm468);
end.
