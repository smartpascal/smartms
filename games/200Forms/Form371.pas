unit Form371;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm371 = class(TW3Form)
  private
    {$I 'Form371:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm371 }

procedure TForm371.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm371.InitializeObject;
begin
  inherited;
  {$I 'Form371:impl'}
end;
 
procedure TForm371.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm371);
end.
