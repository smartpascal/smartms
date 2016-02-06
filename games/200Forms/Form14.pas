unit Form14;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm14 = class(TW3Form)
  private
    {$I 'Form14:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm14 }

procedure TForm14.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm14.InitializeObject;
begin
  inherited;
  {$I 'Form14:impl'}
end;
 
procedure TForm14.Resize;
begin
  inherited;
end;

procedure TForm14.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm14);
end.
