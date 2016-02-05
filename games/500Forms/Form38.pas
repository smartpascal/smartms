unit Form38;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm38 = class(TW3Form)
  private
    {$I 'Form38:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm38 }

procedure TForm38.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm38.InitializeObject;
begin
  inherited;
  {$I 'Form38:impl'}
end;
 
procedure TForm38.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm38);
end.
