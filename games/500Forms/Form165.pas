unit Form165;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm165 = class(TW3Form)
  private
    {$I 'Form165:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm165 }

procedure TForm165.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm165.InitializeObject;
begin
  inherited;
  {$I 'Form165:impl'}
end;
 
procedure TForm165.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm165);
end.
