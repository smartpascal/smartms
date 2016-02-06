unit Form147;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm147 = class(TW3Form)
  private
    {$I 'Form147:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm147 }

procedure TForm147.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm147.InitializeObject;
begin
  inherited;
  {$I 'Form147:impl'}
end;
 
procedure TForm147.Resize;
begin
  inherited;
end;

procedure TForm147.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm147);
end.
