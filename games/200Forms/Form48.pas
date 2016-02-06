unit Form48;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm48 = class(TW3Form)
  private
    {$I 'Form48:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm48 }

procedure TForm48.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm48.InitializeObject;
begin
  inherited;
  {$I 'Form48:impl'}
end;
 
procedure TForm48.Resize;
begin
  inherited;
end;

procedure TForm48.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm48);
end.
