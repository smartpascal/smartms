unit Form478;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm478 = class(TW3Form)
  private
    {$I 'Form478:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm478 }

procedure TForm478.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm478.InitializeObject;
begin
  inherited;
  {$I 'Form478:impl'}
end;
 
procedure TForm478.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm478);
end.
