unit Form409;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm409 = class(TW3Form)
  private
    {$I 'Form409:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm409 }

procedure TForm409.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm409.InitializeObject;
begin
  inherited;
  {$I 'Form409:impl'}
end;
 
procedure TForm409.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm409);
end.
