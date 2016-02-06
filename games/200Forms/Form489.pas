unit Form489;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm489 = class(TW3Form)
  private
    {$I 'Form489:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm489 }

procedure TForm489.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm489.InitializeObject;
begin
  inherited;
  {$I 'Form489:impl'}
end;
 
procedure TForm489.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm489);
end.
