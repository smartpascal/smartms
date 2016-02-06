unit Form40;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm40 = class(TW3Form)
  private
    {$I 'Form40:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm40 }

procedure TForm40.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm40.InitializeObject;
begin
  inherited;
  {$I 'Form40:impl'}
end;
 
procedure TForm40.Resize;
begin
  inherited;
end;

procedure TForm40.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm40);
end.
