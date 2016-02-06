unit Form386;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm386 = class(TW3Form)
  private
    {$I 'Form386:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm386 }

procedure TForm386.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm386.InitializeObject;
begin
  inherited;
  {$I 'Form386:impl'}
end;
 
procedure TForm386.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm386);
end.
