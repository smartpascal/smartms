unit Form481;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm481 = class(TW3Form)
  private
    {$I 'Form481:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm481 }

procedure TForm481.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm481.InitializeObject;
begin
  inherited;
  {$I 'Form481:impl'}
end;
 
procedure TForm481.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm481);
end.
