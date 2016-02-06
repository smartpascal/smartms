unit Form97;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm97 = class(TW3Form)
  private
    {$I 'Form97:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm97 }

procedure TForm97.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm97.InitializeObject;
begin
  inherited;
  {$I 'Form97:impl'}
end;
 
procedure TForm97.Resize;
begin
  inherited;
end;

procedure TForm97.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm97);
end.
