unit Form95;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm95 = class(TW3Form)
  private
    {$I 'Form95:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm95 }

procedure TForm95.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm95.InitializeObject;
begin
  inherited;
  {$I 'Form95:impl'}
end;
 
procedure TForm95.Resize;
begin
  inherited;
end;

procedure TForm95.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm95);
end.
