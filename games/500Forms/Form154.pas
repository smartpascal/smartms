unit Form154;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm154 = class(TW3Form)
  private
    {$I 'Form154:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm154 }

procedure TForm154.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm154.InitializeObject;
begin
  inherited;
  {$I 'Form154:impl'}
end;
 
procedure TForm154.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm154);
end.
