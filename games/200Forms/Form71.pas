unit Form71;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm71 = class(TW3Form)
  private
    {$I 'Form71:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm71 }

procedure TForm71.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm71.InitializeObject;
begin
  inherited;
  {$I 'Form71:impl'}
end;
 
procedure TForm71.Resize;
begin
  inherited;
end;

procedure TForm71.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm71);
end.
