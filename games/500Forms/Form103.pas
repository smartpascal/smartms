unit Form103;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm103 = class(TW3Form)
  private
    {$I 'Form103:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm103 }

procedure TForm103.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm103.InitializeObject;
begin
  inherited;
  {$I 'Form103:impl'}
end;
 
procedure TForm103.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm103);
end.
