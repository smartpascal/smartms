unit Form111;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm111 = class(TW3Form)
  private
    {$I 'Form111:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm111 }

procedure TForm111.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm111.InitializeObject;
begin
  inherited;
  {$I 'Form111:impl'}
end;
 
procedure TForm111.Resize;
begin
  inherited;
end;

procedure TForm111.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm111);
end.
