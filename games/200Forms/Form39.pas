unit Form39;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm39 = class(TW3Form)
  private
    {$I 'Form39:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm39 }

procedure TForm39.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm39.InitializeObject;
begin
  inherited;
  {$I 'Form39:impl'}
end;
 
procedure TForm39.Resize;
begin
  inherited;
end;

procedure TForm39.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm39);
end.
