unit Form26;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm26 = class(TW3Form)
  private
    {$I 'Form26:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm26 }

procedure TForm26.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm26.InitializeObject;
begin
  inherited;
  {$I 'Form26:impl'}
end;
 
procedure TForm26.Resize;
begin
  inherited;
end;

procedure TForm26.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm26);
end.
