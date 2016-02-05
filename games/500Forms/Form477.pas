unit Form477;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm477 = class(TW3Form)
  private
    {$I 'Form477:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm477 }

procedure TForm477.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm477.InitializeObject;
begin
  inherited;
  {$I 'Form477:impl'}
end;
 
procedure TForm477.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm477);
end.
