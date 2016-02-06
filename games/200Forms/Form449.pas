unit Form449;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm449 = class(TW3Form)
  private
    {$I 'Form449:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm449 }

procedure TForm449.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm449.InitializeObject;
begin
  inherited;
  {$I 'Form449:impl'}
end;
 
procedure TForm449.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm449);
end.
