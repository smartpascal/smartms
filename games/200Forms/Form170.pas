unit Form170;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm170 = class(TW3Form)
  private
    {$I 'Form170:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm170 }

procedure TForm170.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm170.InitializeObject;
begin
  inherited;
  {$I 'Form170:impl'}
end;
 
procedure TForm170.Resize;
begin
  inherited;
end;

procedure TForm170.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm170);
end.
