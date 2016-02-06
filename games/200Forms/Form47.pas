unit Form47;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm47 = class(TW3Form)
  private
    {$I 'Form47:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm47 }

procedure TForm47.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm47.InitializeObject;
begin
  inherited;
  {$I 'Form47:impl'}
end;
 
procedure TForm47.Resize;
begin
  inherited;
end;

procedure TForm47.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm47);
end.
