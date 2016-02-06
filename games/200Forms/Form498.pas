unit Form498;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm498 = class(TW3Form)
  private
    {$I 'Form498:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm498 }

procedure TForm498.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm498.InitializeObject;
begin
  inherited;
  {$I 'Form498:impl'}
end;
 
procedure TForm498.Resize;
begin
  inherited;
end;

procedure TForm498.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm498);
end.
