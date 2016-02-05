unit Form160;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm160 = class(TW3Form)
  private
    {$I 'Form160:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm160 }

procedure TForm160.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm160.InitializeObject;
begin
  inherited;
  {$I 'Form160:impl'}
end;
 
procedure TForm160.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm160);
end.
