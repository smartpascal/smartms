unit Form223;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm223 = class(TW3Form)
  private
    {$I 'Form223:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm223 }

procedure TForm223.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm223.InitializeObject;
begin
  inherited;
  {$I 'Form223:impl'}
end;
 
procedure TForm223.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm223);
end.
