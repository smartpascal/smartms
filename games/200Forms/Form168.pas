unit Form168;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm168 = class(TW3Form)
  private
    {$I 'Form168:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm168 }

procedure TForm168.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm168.InitializeObject;
begin
  inherited;
  {$I 'Form168:impl'}
end;
 
procedure TForm168.Resize;
begin
  inherited;
end;

procedure TForm168.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm168);
end.
