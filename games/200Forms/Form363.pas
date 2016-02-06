unit Form363;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm363 = class(TW3Form)
  private
    {$I 'Form363:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm363 }

procedure TForm363.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm363.InitializeObject;
begin
  inherited;
  {$I 'Form363:impl'}
end;
 
procedure TForm363.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm363);
end.
