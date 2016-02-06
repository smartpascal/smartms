unit Form188;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm188 = class(TW3Form)
  private
    {$I 'Form188:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm188 }

procedure TForm188.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm188.InitializeObject;
begin
  inherited;
  {$I 'Form188:impl'}
end;
 
procedure TForm188.Resize;
begin
  inherited;
end;

procedure TForm188.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm188);
end.
