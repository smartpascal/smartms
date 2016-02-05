unit Form293;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm293 = class(TW3Form)
  private
    {$I 'Form293:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm293 }

procedure TForm293.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm293.InitializeObject;
begin
  inherited;
  {$I 'Form293:impl'}
end;
 
procedure TForm293.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm293);
end.
