unit Form139;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm139 = class(TW3Form)
  private
    {$I 'Form139:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm139 }

procedure TForm139.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm139.InitializeObject;
begin
  inherited;
  {$I 'Form139:impl'}
end;
 
procedure TForm139.Resize;
begin
  inherited;
end;

procedure TForm139.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm139);
end.
