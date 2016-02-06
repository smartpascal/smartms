unit Form27;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm27 = class(TW3Form)
  private
    {$I 'Form27:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm27 }

procedure TForm27.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm27.InitializeObject;
begin
  inherited;
  {$I 'Form27:impl'}
end;
 
procedure TForm27.Resize;
begin
  inherited;
end;

procedure TForm27.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm27);
end.
