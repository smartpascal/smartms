unit Form171;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm171 = class(TW3Form)
  private
    {$I 'Form171:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm171 }

procedure TForm171.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm171.InitializeObject;
begin
  inherited;
  {$I 'Form171:impl'}
end;
 
procedure TForm171.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm171);
end.
