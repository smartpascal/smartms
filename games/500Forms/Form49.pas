unit Form49;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm49 = class(TW3Form)
  private
    {$I 'Form49:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm49 }

procedure TForm49.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm49.InitializeObject;
begin
  inherited;
  {$I 'Form49:impl'}
end;
 
procedure TForm49.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm49);
end.
