unit Form122;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm122 = class(TW3Form)
  private
    {$I 'Form122:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm122 }

procedure TForm122.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm122.InitializeObject;
begin
  inherited;
  {$I 'Form122:impl'}
end;
 
procedure TForm122.Resize;
begin
  inherited;
end;

procedure TForm122.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm122);
end.
