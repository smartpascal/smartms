unit Form236;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm236 = class(TW3Form)
  private
    {$I 'Form236:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm236 }

procedure TForm236.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm236.InitializeObject;
begin
  inherited;
  {$I 'Form236:impl'}
end;
 
procedure TForm236.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm236);
end.
