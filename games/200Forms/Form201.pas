unit Form201;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm201 = class(TW3Form)
  private
    {$I 'Form201:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm201 }

procedure TForm201.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm201.InitializeObject;
begin
  inherited;
  {$I 'Form201:impl'}
end;
 
procedure TForm201.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm201);
end.
