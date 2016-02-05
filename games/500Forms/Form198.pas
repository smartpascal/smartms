unit Form198;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm198 = class(TW3Form)
  private
    {$I 'Form198:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm198 }

procedure TForm198.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm198.InitializeObject;
begin
  inherited;
  {$I 'Form198:impl'}
end;
 
procedure TForm198.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm198);
end.
