unit Form135;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm135 = class(TW3Form)
  private
    {$I 'Form135:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm135 }

procedure TForm135.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm135.InitializeObject;
begin
  inherited;
  {$I 'Form135:impl'}
end;
 
procedure TForm135.Resize;
begin
  inherited;
end;

procedure TForm135.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm135);
end.
