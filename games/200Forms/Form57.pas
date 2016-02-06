unit Form57;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm57 = class(TW3Form)
  private
    {$I 'Form57:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm57 }

procedure TForm57.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm57.InitializeObject;
begin
  inherited;
  {$I 'Form57:impl'}
end;
 
procedure TForm57.Resize;
begin
  inherited;
end;

procedure TForm57.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm57);
end.
