unit Form166;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm166 = class(TW3Form)
  private
    {$I 'Form166:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm166 }

procedure TForm166.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm166.InitializeObject;
begin
  inherited;
  {$I 'Form166:impl'}
end;
 
procedure TForm166.Resize;
begin
  inherited;
end;

procedure TForm166.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm166);
end.
