unit Form196;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm196 = class(TW3Form)
  private
    {$I 'Form196:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm196 }

procedure TForm196.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm196.InitializeObject;
begin
  inherited;
  {$I 'Form196:impl'}
end;
 
procedure TForm196.Resize;
begin
  inherited;
end;

procedure TForm196.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm196);
end.
