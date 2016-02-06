unit Form207;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm207 = class(TW3Form)
  private
    {$I 'Form207:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm207 }

procedure TForm207.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm207.InitializeObject;
begin
  inherited;
  {$I 'Form207:impl'}
end;
 
procedure TForm207.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm207);
end.
