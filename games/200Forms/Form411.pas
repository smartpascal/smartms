unit Form411;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm411 = class(TW3Form)
  private
    {$I 'Form411:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm411 }

procedure TForm411.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm411.InitializeObject;
begin
  inherited;
  {$I 'Form411:impl'}
end;
 
procedure TForm411.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm411);
end.
