unit Form427;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm427 = class(TW3Form)
  private
    {$I 'Form427:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm427 }

procedure TForm427.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm427.InitializeObject;
begin
  inherited;
  {$I 'Form427:impl'}
end;
 
procedure TForm427.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm427);
end.
