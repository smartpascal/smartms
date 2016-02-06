unit Form312;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm312 = class(TW3Form)
  private
    {$I 'Form312:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm312 }

procedure TForm312.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm312.InitializeObject;
begin
  inherited;
  {$I 'Form312:impl'}
end;
 
procedure TForm312.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm312);
end.
