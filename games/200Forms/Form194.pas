unit Form194;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm194 = class(TW3Form)
  private
    {$I 'Form194:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm194 }

procedure TForm194.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm194.InitializeObject;
begin
  inherited;
  {$I 'Form194:impl'}
end;
 
procedure TForm194.Resize;
begin
  inherited;
end;

procedure TForm194.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm194);
end.
