unit Form118;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm118 = class(TW3Form)
  private
    {$I 'Form118:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm118 }

procedure TForm118.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm118.InitializeObject;
begin
  inherited;
  {$I 'Form118:impl'}
end;
 
procedure TForm118.Resize;
begin
  inherited;
end;

procedure TForm118.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm118);
end.
