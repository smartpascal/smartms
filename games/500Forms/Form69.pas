unit Form69;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm69 = class(TW3Form)
  private
    {$I 'Form69:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm69 }

procedure TForm69.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm69.InitializeObject;
begin
  inherited;
  {$I 'Form69:impl'}
end;
 
procedure TForm69.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm69);
end.
