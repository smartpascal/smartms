unit Form443;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm443 = class(TW3Form)
  private
    {$I 'Form443:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm443 }

procedure TForm443.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm443.InitializeObject;
begin
  inherited;
  {$I 'Form443:impl'}
end;
 
procedure TForm443.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm443);
end.
