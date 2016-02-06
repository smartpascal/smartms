unit Form6;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm6 = class(TW3Form)
  private
    {$I 'Form6:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm6 }

procedure TForm6.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm6.InitializeObject;
begin
  inherited;
  {$I 'Form6:impl'}
end;
 
procedure TForm6.Resize;
begin
  inherited;
end;

procedure TForm6.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm6);
end.
