unit Form500;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm500 = class(TW3Form)
  private
    {$I 'Form500:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm500 }

procedure TForm500.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm500.InitializeObject;
begin
  inherited;
  {$I 'Form500:impl'}
end;
 
procedure TForm500.Resize;
begin
  inherited;
end;

procedure TForm500.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm500);
end.
