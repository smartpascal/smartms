unit Form248;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm248 = class(TW3Form)
  private
    {$I 'Form248:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm248 }

procedure TForm248.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm248.InitializeObject;
begin
  inherited;
  {$I 'Form248:impl'}
end;
 
procedure TForm248.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm248);
end.
