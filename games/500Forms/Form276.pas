unit Form276;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm276 = class(TW3Form)
  private
    {$I 'Form276:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm276 }

procedure TForm276.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm276.InitializeObject;
begin
  inherited;
  {$I 'Form276:impl'}
end;
 
procedure TForm276.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm276);
end.
