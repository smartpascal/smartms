unit Form13;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm13 = class(TW3Form)
  private
    {$I 'Form13:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm13 }

procedure TForm13.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm13.InitializeObject;
begin
  inherited;
  {$I 'Form13:impl'}
end;
 
procedure TForm13.Resize;
begin
  inherited;
end;

procedure TForm13.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm13);
end.
