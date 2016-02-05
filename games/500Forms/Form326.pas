unit Form326;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm326 = class(TW3Form)
  private
    {$I 'Form326:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm326 }

procedure TForm326.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm326.InitializeObject;
begin
  inherited;
  {$I 'Form326:impl'}
end;
 
procedure TForm326.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm326);
end.
