unit Form7;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm7 = class(TW3Form)
  private
    {$I 'Form7:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm7 }

procedure TForm7.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm7.InitializeObject;
begin
  inherited;
  {$I 'Form7:impl'}
end;
 
procedure TForm7.Resize;
begin
  inherited;
end;

procedure TForm7.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm7);
end.
