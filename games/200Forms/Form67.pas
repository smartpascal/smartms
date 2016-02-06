unit Form67;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm67 = class(TW3Form)
  private
    {$I 'Form67:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm67 }

procedure TForm67.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm67.InitializeObject;
begin
  inherited;
  {$I 'Form67:impl'}
end;
 
procedure TForm67.Resize;
begin
  inherited;
end;

procedure TForm67.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm67);
end.
