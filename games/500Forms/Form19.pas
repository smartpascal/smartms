unit Form19;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm19 = class(TW3Form)
  private
    {$I 'Form19:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm19 }

procedure TForm19.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm19.InitializeObject;
begin
  inherited;
  {$I 'Form19:impl'}
end;
 
procedure TForm19.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm19);
end.
