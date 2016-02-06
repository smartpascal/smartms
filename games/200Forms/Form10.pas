unit Form10;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm10 = class(TW3Form)
  private
    {$I 'Form10:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm10 }

procedure TForm10.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm10.InitializeObject;
begin
  inherited;
  {$I 'Form10:impl'}
end;
 
procedure TForm10.Resize;
begin
  inherited;
end;

procedure TForm10.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm10);
end.
