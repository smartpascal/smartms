unit Form252;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm252 = class(TW3Form)
  private
    {$I 'Form252:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm252 }

procedure TForm252.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm252.InitializeObject;
begin
  inherited;
  {$I 'Form252:impl'}
end;
 
procedure TForm252.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm252);
end.
