unit Form141;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm141 = class(TW3Form)
  private
    {$I 'Form141:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm141 }

procedure TForm141.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm141.InitializeObject;
begin
  inherited;
  {$I 'Form141:impl'}
end;
 
procedure TForm141.Resize;
begin
  inherited;
end;

procedure TForm141.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm141);
end.
