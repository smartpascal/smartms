unit Form31;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm31 = class(TW3Form)
  private
    {$I 'Form31:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm31 }

procedure TForm31.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm31.InitializeObject;
begin
  inherited;
  {$I 'Form31:impl'}
end;
 
procedure TForm31.Resize;
begin
  inherited;
end;

procedure TForm31.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm31);
end.
