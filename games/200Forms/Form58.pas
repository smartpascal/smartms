unit Form58;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm58 = class(TW3Form)
  private
    {$I 'Form58:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm58 }

procedure TForm58.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm58.InitializeObject;
begin
  inherited;
  {$I 'Form58:impl'}
end;
 
procedure TForm58.Resize;
begin
  inherited;
end;

procedure TForm58.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm58);
end.
