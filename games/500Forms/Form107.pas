unit Form107;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm107 = class(TW3Form)
  private
    {$I 'Form107:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm107 }

procedure TForm107.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm107.InitializeObject;
begin
  inherited;
  {$I 'Form107:impl'}
end;
 
procedure TForm107.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm107);
end.
