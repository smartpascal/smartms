unit Form239;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm239 = class(TW3Form)
  private
    {$I 'Form239:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm239 }

procedure TForm239.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm239.InitializeObject;
begin
  inherited;
  {$I 'Form239:impl'}
end;
 
procedure TForm239.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm239);
end.
