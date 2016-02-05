unit Form192;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm192 = class(TW3Form)
  private
    {$I 'Form192:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm192 }

procedure TForm192.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm192.InitializeObject;
begin
  inherited;
  {$I 'Form192:impl'}
end;
 
procedure TForm192.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm192);
end.
