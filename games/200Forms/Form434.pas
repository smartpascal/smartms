unit Form434;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm434 = class(TW3Form)
  private
    {$I 'Form434:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm434 }

procedure TForm434.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm434.InitializeObject;
begin
  inherited;
  {$I 'Form434:impl'}
end;
 
procedure TForm434.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm434);
end.
