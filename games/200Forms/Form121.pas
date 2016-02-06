unit Form121;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm121 = class(TW3Form)
  private
    {$I 'Form121:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm121 }

procedure TForm121.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm121.InitializeObject;
begin
  inherited;
  {$I 'Form121:impl'}
end;
 
procedure TForm121.Resize;
begin
  inherited;
end;

procedure TForm121.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm121);
end.
