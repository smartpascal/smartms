unit Form145;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm145 = class(TW3Form)
  private
    {$I 'Form145:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm145 }

procedure TForm145.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm145.InitializeObject;
begin
  inherited;
  {$I 'Form145:impl'}
end;
 
procedure TForm145.Resize;
begin
  inherited;
end;

procedure TForm145.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm145);
end.
