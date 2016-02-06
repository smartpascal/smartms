unit Form12;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm12 = class(TW3Form)
  private
    {$I 'Form12:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm12 }

procedure TForm12.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm12.InitializeObject;
begin
  inherited;
  {$I 'Form12:impl'}
end;
 
procedure TForm12.Resize;
begin
  inherited;
end;

procedure TForm12.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm12);
end.
