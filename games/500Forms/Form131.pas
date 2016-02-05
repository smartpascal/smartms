unit Form131;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm131 = class(TW3Form)
  private
    {$I 'Form131:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm131 }

procedure TForm131.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm131.InitializeObject;
begin
  inherited;
  {$I 'Form131:impl'}
end;
 
procedure TForm131.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm131);
end.
