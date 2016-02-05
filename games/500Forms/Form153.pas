unit Form153;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm153 = class(TW3Form)
  private
    {$I 'Form153:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm153 }

procedure TForm153.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm153.InitializeObject;
begin
  inherited;
  {$I 'Form153:impl'}
end;
 
procedure TForm153.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm153);
end.
