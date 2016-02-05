unit Form355;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm355 = class(TW3Form)
  private
    {$I 'Form355:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm355 }

procedure TForm355.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm355.InitializeObject;
begin
  inherited;
  {$I 'Form355:impl'}
end;
 
procedure TForm355.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm355);
end.
