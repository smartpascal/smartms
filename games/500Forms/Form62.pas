unit Form62;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm62 = class(TW3Form)
  private
    {$I 'Form62:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm62 }

procedure TForm62.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm62.InitializeObject;
begin
  inherited;
  {$I 'Form62:impl'}
end;
 
procedure TForm62.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm62);
end.
