unit Form203;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm203 = class(TW3Form)
  private
    {$I 'Form203:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm203 }

procedure TForm203.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm203.InitializeObject;
begin
  inherited;
  {$I 'Form203:impl'}
end;
 
procedure TForm203.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm203);
end.
