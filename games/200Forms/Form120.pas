unit Form120;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm120 = class(TW3Form)
  private
    {$I 'Form120:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm120 }

procedure TForm120.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm120.InitializeObject;
begin
  inherited;
  {$I 'Form120:impl'}
end;
 
procedure TForm120.Resize;
begin
  inherited;
end;

procedure TForm120.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm120);
end.
