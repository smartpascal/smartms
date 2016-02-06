unit Form30;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm30 = class(TW3Form)
  private
    {$I 'Form30:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm30 }

procedure TForm30.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm30.InitializeObject;
begin
  inherited;
  {$I 'Form30:impl'}
end;
 
procedure TForm30.Resize;
begin
  inherited;
end;

procedure TForm30.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm30);
end.
