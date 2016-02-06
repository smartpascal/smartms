unit Form138;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm138 = class(TW3Form)
  private
    {$I 'Form138:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm138 }

procedure TForm138.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm138.InitializeObject;
begin
  inherited;
  {$I 'Form138:impl'}
end;
 
procedure TForm138.Resize;
begin
  inherited;
end;

procedure TForm138.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm138);
end.
