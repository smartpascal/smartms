unit Form144;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm144 = class(TW3Form)
  private
    {$I 'Form144:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm144 }

procedure TForm144.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm144.InitializeObject;
begin
  inherited;
  {$I 'Form144:impl'}
end;
 
procedure TForm144.Resize;
begin
  inherited;
end;

procedure TForm144.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm144);
end.
