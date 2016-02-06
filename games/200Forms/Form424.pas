unit Form424;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm424 = class(TW3Form)
  private
    {$I 'Form424:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm424 }

procedure TForm424.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm424.InitializeObject;
begin
  inherited;
  {$I 'Form424:impl'}
end;
 
procedure TForm424.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm424);
end.
