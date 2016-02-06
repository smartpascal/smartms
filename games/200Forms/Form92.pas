unit Form92;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm92 = class(TW3Form)
  private
    {$I 'Form92:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm92 }

procedure TForm92.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm92.InitializeObject;
begin
  inherited;
  {$I 'Form92:impl'}
end;
 
procedure TForm92.Resize;
begin
  inherited;
end;

procedure TForm92.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm92);
end.
