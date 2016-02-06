unit Form87;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm87 = class(TW3Form)
  private
    {$I 'Form87:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm87 }

procedure TForm87.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm87.InitializeObject;
begin
  inherited;
  {$I 'Form87:impl'}
end;
 
procedure TForm87.Resize;
begin
  inherited;
end;

procedure TForm87.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm87);
end.
