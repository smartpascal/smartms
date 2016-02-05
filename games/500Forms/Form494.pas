unit Form494;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm494 = class(TW3Form)
  private
    {$I 'Form494:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm494 }

procedure TForm494.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm494.InitializeObject;
begin
  inherited;
  {$I 'Form494:impl'}
end;
 
procedure TForm494.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm494);
end.
