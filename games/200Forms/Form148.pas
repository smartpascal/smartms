unit Form148;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm148 = class(TW3Form)
  private
    {$I 'Form148:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm148 }

procedure TForm148.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm148.InitializeObject;
begin
  inherited;
  {$I 'Form148:impl'}
end;
 
procedure TForm148.Resize;
begin
  inherited;
end;

procedure TForm148.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm148);
end.
