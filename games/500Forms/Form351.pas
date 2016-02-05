unit Form351;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm351 = class(TW3Form)
  private
    {$I 'Form351:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm351 }

procedure TForm351.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm351.InitializeObject;
begin
  inherited;
  {$I 'Form351:impl'}
end;
 
procedure TForm351.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm351);
end.
