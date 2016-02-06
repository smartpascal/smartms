unit Form72;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm72 = class(TW3Form)
  private
    {$I 'Form72:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm72 }

procedure TForm72.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm72.InitializeObject;
begin
  inherited;
  {$I 'Form72:impl'}
end;
 
procedure TForm72.Resize;
begin
  inherited;
end;

procedure TForm72.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm72);
end.
