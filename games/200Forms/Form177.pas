unit Form177;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm177 = class(TW3Form)
  private
    {$I 'Form177:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm177 }

procedure TForm177.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm177.InitializeObject;
begin
  inherited;
  {$I 'Form177:impl'}
end;
 
procedure TForm177.Resize;
begin
  inherited;
end;

procedure TForm177.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm177);
end.
