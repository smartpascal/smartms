unit Form15;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm15 = class(TW3Form)
  private
    {$I 'Form15:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm15 }

procedure TForm15.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm15.InitializeObject;
begin
  inherited;
  {$I 'Form15:impl'}
end;
 
procedure TForm15.Resize;
begin
  inherited;
end;

procedure TForm15.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm15);
end.
