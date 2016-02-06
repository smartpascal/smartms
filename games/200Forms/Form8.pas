unit Form8;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm8 = class(TW3Form)
  private
    {$I 'Form8:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm8 }

procedure TForm8.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm8.InitializeObject;
begin
  inherited;
  {$I 'Form8:impl'}
end;
 
procedure TForm8.Resize;
begin
  inherited;
end;

procedure TForm8.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm8);
end.
