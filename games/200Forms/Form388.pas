unit Form388;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm388 = class(TW3Form)
  private
    {$I 'Form388:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm388 }

procedure TForm388.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm388.InitializeObject;
begin
  inherited;
  {$I 'Form388:impl'}
end;
 
procedure TForm388.Resize;
begin
  inherited;
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm388);
end.
