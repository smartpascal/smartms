unit Form193;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm193 = class(TW3Form)
  private
    {$I 'Form193:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm193 }

procedure TForm193.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm193.InitializeObject;
begin
  inherited;
  {$I 'Form193:impl'}
end;
 
procedure TForm193.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm193);
end.
