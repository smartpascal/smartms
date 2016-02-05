unit Form157;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm157 = class(TW3Form)
  private
    {$I 'Form157:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm157 }

procedure TForm157.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm157.InitializeObject;
begin
  inherited;
  {$I 'Form157:impl'}
end;
 
procedure TForm157.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm157);
end.
