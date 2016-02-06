unit Form331;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm331 = class(TW3Form)
  private
    {$I 'Form331:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm331 }

procedure TForm331.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm331.InitializeObject;
begin
  inherited;
  {$I 'Form331:impl'}
end;
 
procedure TForm331.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm331);
end.
