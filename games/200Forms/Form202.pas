unit Form202;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm202 = class(TW3Form)
  private
    {$I 'Form202:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm202 }

procedure TForm202.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm202.InitializeObject;
begin
  inherited;
  {$I 'Form202:impl'}
end;
 
procedure TForm202.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm202);
end.
