unit Form98;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm98 = class(TW3Form)
  private
    {$I 'Form98:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm98 }

procedure TForm98.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm98.InitializeObject;
begin
  inherited;
  {$I 'Form98:impl'}
end;
 
procedure TForm98.Resize;
begin
  inherited;
end;

procedure TForm98.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm98);
end.
