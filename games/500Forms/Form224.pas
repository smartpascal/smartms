unit Form224;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm224 = class(TW3Form)
  private
    {$I 'Form224:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm224 }

procedure TForm224.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm224.InitializeObject;
begin
  inherited;
  {$I 'Form224:impl'}
end;
 
procedure TForm224.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm224);
end.
