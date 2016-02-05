unit Form16;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm16 = class(TW3Form)
  private
    {$I 'Form16:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm16 }

procedure TForm16.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm16.InitializeObject;
begin
  inherited;
  {$I 'Form16:impl'}
end;
 
procedure TForm16.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm16);
end.
