unit Form283;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm283 = class(TW3Form)
  private
    {$I 'Form283:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm283 }

procedure TForm283.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm283.InitializeObject;
begin
  inherited;
  {$I 'Form283:impl'}
end;
 
procedure TForm283.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm283);
end.
