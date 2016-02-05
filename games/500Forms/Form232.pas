unit Form232;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm232 = class(TW3Form)
  private
    {$I 'Form232:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm232 }

procedure TForm232.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm232.InitializeObject;
begin
  inherited;
  {$I 'Form232:impl'}
end;
 
procedure TForm232.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm232);
end.
