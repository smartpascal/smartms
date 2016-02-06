unit Form83;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm83 = class(TW3Form)
  private
    {$I 'Form83:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm83 }

procedure TForm83.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm83.InitializeObject;
begin
  inherited;
  {$I 'Form83:impl'}
end;
 
procedure TForm83.Resize;
begin
  inherited;
end;

procedure TForm83.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm83);
end.
