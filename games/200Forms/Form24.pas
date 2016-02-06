unit Form24;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm24 = class(TW3Form)
  private
    {$I 'Form24:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm24 }

procedure TForm24.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm24.InitializeObject;
begin
  inherited;
  {$I 'Form24:impl'}
end;
 
procedure TForm24.Resize;
begin
  inherited;
end;

procedure TForm24.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm24);
end.
