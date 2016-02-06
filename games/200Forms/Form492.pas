unit Form492;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm492 = class(TW3Form)
  private
    {$I 'Form492:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm492 }

procedure TForm492.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm492.InitializeObject;
begin
  inherited;
  {$I 'Form492:impl'}
end;
 
procedure TForm492.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm492);
end.
