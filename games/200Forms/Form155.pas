unit Form155;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm155 = class(TW3Form)
  private
    {$I 'Form155:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm155 }

procedure TForm155.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm155.InitializeObject;
begin
  inherited;
  {$I 'Form155:impl'}
end;
 
procedure TForm155.Resize;
begin
  inherited;
end;

procedure TForm155.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm155);
end.
