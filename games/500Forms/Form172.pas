unit Form172;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm172 = class(TW3Form)
  private
    {$I 'Form172:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm172 }

procedure TForm172.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm172.InitializeObject;
begin
  inherited;
  {$I 'Form172:impl'}
end;
 
procedure TForm172.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm172);
end.
