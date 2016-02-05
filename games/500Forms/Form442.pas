unit Form442;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm442 = class(TW3Form)
  private
    {$I 'Form442:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm442 }

procedure TForm442.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm442.InitializeObject;
begin
  inherited;
  {$I 'Form442:impl'}
end;
 
procedure TForm442.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm442);
end.
