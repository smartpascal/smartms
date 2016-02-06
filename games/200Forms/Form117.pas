unit Form117;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm117 = class(TW3Form)
  private
    {$I 'Form117:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm117 }

procedure TForm117.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm117.InitializeObject;
begin
  inherited;
  {$I 'Form117:impl'}
end;
 
procedure TForm117.Resize;
begin
  inherited;
end;

procedure TForm117.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm117);
end.
