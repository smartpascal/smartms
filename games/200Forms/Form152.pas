unit Form152;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm152 = class(TW3Form)
  private
    {$I 'Form152:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm152 }

procedure TForm152.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm152.InitializeObject;
begin
  inherited;
  {$I 'Form152:impl'}
end;
 
procedure TForm152.Resize;
begin
  inherited;
end;

procedure TForm152.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm152);
end.
